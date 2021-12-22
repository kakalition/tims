import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/playpause_button_state.dart';
import 'package:tims/enum/viewmodel_source.dart';
import 'package:tims/viewmodels/animation_center.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/viewmodels/stopwatch_viewmodel.dart';
import 'package:tims/viewmodels/timer_viewmodel.dart';

import '../constants.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({Key? key, required this.source}) : super(key: key);
  final ViewmodelSource source;

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with AnimationMixin {
  MainVM mainViewmodel = Get.find<MainVM>();
  AnimationCenter animationCenter = Get.find<AnimationCenter>();
  TimerVM timerViewmodel = Get.find<TimerVM>();
  dynamic viewmodel;

  late AnimationController playPauseButtonController;
  late AnimationController playPauseIconController;
  late AnimationController revealButtonController;
  late AnimationController timerTimeController;
  late AnimationController stopwatchTimeController;
  late AnimationController timerCircleController;
  late AnimationController stopwatchCircleController;

  @override
  void initState() {
    super.initState();

    // Controller Initialization
    playPauseButtonController = animationCenter.setAnimationController(
        TimsAnimation.playPauseButton, createController());
    playPauseIconController = animationCenter.setAnimationController(
        TimsAnimation.playPauseIcon, createController());
    revealButtonController = animationCenter.setAnimationController(
        TimsAnimation.revealButton, createController());

		if(widget.source == ViewmodelSource.timer) {
			timerTimeController =
				animationCenter.getAnimationController(TimsAnimation.timerTime);
			timerCircleController =
        animationCenter.getAnimationController(TimsAnimation.timerCircle);
		}
		else {
			stopwatchTimeController =
		  	animationCenter.getAnimationController(TimsAnimation.stopwatchTime);
			stopwatchCircleController =
				animationCenter.getAnimationController(TimsAnimation.stopwatchCircle);
		}

    // Viewmodel Assignment
    if (widget.source == ViewmodelSource.timer) {
      viewmodel = Get.find<TimerVM>();
    } else if (widget.source == ViewmodelSource.stopwatch) {
      viewmodel = Get.find<StopwatchVM>();
    }

    // Time Initialization
    if (widget.source == ViewmodelSource.timer) {
      animationCenter.initTimerDuration();
    } else if (widget.source == ViewmodelSource.stopwatch) {
      animationCenter.initStopwatchDuration();
    }

    // Initialize Play Pause Animation
		animationCenter.initPlayPauseAnimation();

    // Animation Initialization
    if (widget.source == ViewmodelSource.timer) {
      animationCenter.getAnimation(TimsAnimation.timerTime)!.addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            debugPrint("Completed");
            timerViewmodel.showNotification();
          }
        },
      );
    }
  }

  void animateButton(PlayPauseButtonState state) async {
		// Button tapped
    if (state == PlayPauseButtonState.tap) {
      viewmodel.toggleTimer();
			// Circle animation
      if (viewmodel.isTimerActive.value) {
        if (widget.source == ViewmodelSource.timer) {
          timerCircleController.forward();
          timerTimeController.forward();
        } else if (widget.source == ViewmodelSource.stopwatch) {
          stopwatchCircleController.repeat();
          stopwatchTimeController.forward();
        }
      } else {}

			// Button forward animation
      await playPauseButtonController.play(
          duration: const Duration(milliseconds: 150));

			// Icon animation
      if (playPauseIconController.isCompleted) {
        playPauseIconController.playReverse(
					duration: const Duration(milliseconds: 150));
      } else if (playPauseIconController.isDismissed) {
        playPauseIconController.play(
					duration: const Duration(milliseconds: 150));
      }
			
			// Reveal animation
      revealButtonController.play(duration: const Duration(milliseconds: 300));

			// Button reverse animation
      await playPauseButtonController.playReverse(
				duration: const Duration(milliseconds: 150));

    // Button holded
    } else if (state == PlayPauseButtonState.hold) {
      await playPauseButtonController.play(
				duration: const Duration(milliseconds: 150));

		// Button tap canceled
    } else if (state == PlayPauseButtonState.cancel) {
      await playPauseButtonController.playReverse(
				duration: const Duration(milliseconds: 150));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Restart Button
        Transform.translate(
          offset:
              animationCenter.getAnimation(TimsAnimation.revealButton)?.value,
          child: Material(
            borderRadius:
                BorderRadius.circular(mainViewmodel.restartButtonSize),
            child: InkWell(
              onTap: () async {
								if(widget.source == ViewmodelSource.timer) {
									await timerTimeController.playReverse(
										duration: const Duration(milliseconds: 200));
									await timerCircleController.playReverse(
										duration: const Duration(milliseconds: 500));
									timerTimeController.duration = viewmodel.currentTimerDuration;
									timerCircleController.duration = viewmodel.currentTimerDuration;
								} 
								else {
									await stopwatchTimeController.playReverse(
										duration: const Duration(milliseconds: 200));
									await stopwatchCircleController.playReverse(
										duration: const Duration(milliseconds: 500));
									stopwatchCircleController.value = 1.0;
									await stopwatchCircleController.playReverse(
										duration: const Duration(milliseconds: 250));
								}
                // timeController.duration = viewmodel.currentTimerDuration;
                viewmodel.turnOffTimer();
                playPauseIconController.playReverse();
                revealButtonController.playReverse(
                    duration: const Duration(milliseconds: 300));
              },
              borderRadius:
                  BorderRadius.circular(mainViewmodel.restartButtonSize),
              child: Container(
                height: mainViewmodel.restartButtonSize,
                width: mainViewmodel.restartButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    mainViewmodel.restartButtonSize,
                  ),
                ),
                child: Icon(
                  Icons.replay,
                  color: whiteColorDarkTheme,
                  size: mainViewmodel.restartIconSize,
                ),
              ),
            ),
          ),
        ),
        // Play/Stop Button
        Transform.scale(
          scale: animationCenter
              .getAnimation(TimsAnimation.playPauseButton)!
              .value,
          child: Material(
            borderRadius: BorderRadius.circular(mainViewmodel.playButtonSize),
            child: InkWell(
              onTap: () {
                animateButton(PlayPauseButtonState.tap);
              },
              onTapDown: (TapDownDetails details) {
                animateButton(PlayPauseButtonState.hold);
              },
              onTapCancel: () {
                animateButton(PlayPauseButtonState.cancel);
              },
              borderRadius: BorderRadius.circular(mainViewmodel.playButtonSize),
              child: Container(
                height: mainViewmodel.playButtonSize,
                width: mainViewmodel.playButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    mainViewmodel.playButtonSize,
                  ),
                ),
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: playPauseIconController,
                    color: whiteColorDarkTheme,
                    size: mainViewmodel.playIconSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
