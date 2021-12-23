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
	TimsAnimation? circleAnim;
  dynamic viewmodel;

  late AnimationController playPauseButtonController;
  late AnimationController playPauseIconController;
  late AnimationController revealButtonController;
	late AnimationController timeController;
	late AnimationController circleController;

	late Animation<double> playPauseButtonAnimation;
	late Animation<double> playPauseIconAnimation;
	late Animation<Offset> revealButtonAnimation;

  @override
  void initState() {
    super.initState();

		// Initialize Circle Anim
    circleAnim = widget.source == ViewmodelSource.timer ? TimsAnimation.timerCircle : TimsAnimation.stopwatchCircle;

    // Controller Initialization
    playPauseButtonController = createController();
    playPauseIconController = createController();
    revealButtonController = createController();
    circleController = animationCenter.getCircleController(
			widget.source == ViewmodelSource.timer ? 
			TimsAnimation.timerCircle : 
			TimsAnimation.stopwatchCircle
		);
    timeController = animationCenter.getTimeController(
			widget.source == ViewmodelSource.timer ? 
			TimsAnimation.timerTime : 
			TimsAnimation.stopwatchTime
		);

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
			debugPrint(animationCenter.getAnimationController(TimsAnimation.stopwatchTime)!.toStringDetails());
    }

    // Initialize Widget Animation;
		playPauseButtonAnimation = animationCenter.initPlayPauseButtonAnimation(playPauseButtonController);
		playPauseIconAnimation = animationCenter.initPlayPauseIconAnimation(playPauseIconController);
		revealButtonAnimation = animationCenter.initRevealButtonAnimation(revealButtonController);
		
    // Animation Initialization
    if (widget.source == ViewmodelSource.timer) {
      animationCenter.getAnimation(TimsAnimation.timerTime)!.addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
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
				if(circleAnim == TimsAnimation.timerCircle) {
					circleController.forward();
				} else {
					circleController.repeat();
				}
				timeController.forward();
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
              revealButtonAnimation.value,
          child: Material(
            borderRadius:
                BorderRadius.circular(mainViewmodel.restartButtonSize),
            child: InkWell(
              onTap: () async {
								// Animate Circle
								await timeController.playReverse(
									duration: const Duration(milliseconds: 200));
								await circleController.playReverse(
									duration: const Duration(milliseconds: 500));

								// Reset Duration
								if(circleAnim == TimsAnimation.timerCircle) {
									timeController.duration = viewmodel.currentTimerDuration;
									circleController.duration = viewmodel.currentTimerDuration;
								} else {
									timeController.duration = const Duration(days: 30);
									circleController.duration = const Duration(milliseconds: 1500);
								}
								// Turning Off Timer
                viewmodel.turnOffClock();

								// Animate Play Icon and Reverse Reveal
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
          scale: playPauseButtonAnimation.value,
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
