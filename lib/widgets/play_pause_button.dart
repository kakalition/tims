import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/playpause_button_state.dart';
import 'package:tims/enum/viewmodel_source.dart';
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
	TimerVM timerViewmodel = Get.find<TimerVM>();
  dynamic viewmodel;

  late AnimationController playPauseButtonController;
  late AnimationController playPauseIconController;
  late AnimationController revealController;
  late AnimationController timeController;
  late Animation buttonAnimation;
  late Animation iconButtonAnimation;
  late Animation revealAnimation;
  late Animation timeAnimation;

  @override
  void initState() {
    super.initState();

    // Controller Initialization
    playPauseButtonController = createController();
    playPauseIconController = createController();
    revealController = createController();
    if (widget.source == ViewmodelSource.timer) {
      viewmodel = Get.find<TimerVM>();
    } else if (widget.source == ViewmodelSource.stopwatch) {
      viewmodel = Get.find<StopwatchVM>();
    }
    timeController = viewmodel.getTimeController();

    // Animation Initialization
    buttonAnimation =
        Tween<double>(begin: 1, end: 1.05).animate(playPauseButtonController);
    iconButtonAnimation = Tween<double>(begin: 0, end: 1)
        .animate(playPauseIconController)
        .drive(CurveTween(curve: Curves.easeOut));
    revealAnimation = Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, mainViewmodel.revealLengthFactor))
        .animate(revealController.drive(CurveTween(curve: Curves.easeOut)));
    if (widget.source == ViewmodelSource.timer) {
      timeAnimation = viewmodel.getTimerTween().animate(timeController)
        ..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
							debugPrint("Completed");
							timerViewmodel.showNotification();
						}
          },
        );
    }
    if (widget.source == ViewmodelSource.timer) {
      timeController.duration = viewmodel.currentTimerDuration;
    } else if (widget.source == ViewmodelSource.stopwatch) {
      timeController.duration = const Duration(milliseconds: 1500);
    }
  }

  void animateButton(PlayPauseButtonState state) async {
    if (state == PlayPauseButtonState.tap) {
      viewmodel.toggleTimer();
      if (viewmodel.isTimerActive.value) {
        if (widget.source == ViewmodelSource.timer) {
          timeController.forward();
        } else if (widget.source == ViewmodelSource.stopwatch) {
          timeController.repeat();
        }
      } else {
        timeController.stop();
      }
      await playPauseButtonController.play(
          duration: const Duration(milliseconds: 150));
      if (playPauseIconController.isCompleted) {
        playPauseIconController.playReverse(
            duration: const Duration(milliseconds: 150));
      } else if (playPauseIconController.isDismissed) {
        playPauseIconController.play(
            duration: const Duration(milliseconds: 150));
      }
      revealController.play(duration: const Duration(milliseconds: 300));
      await playPauseButtonController.playReverse(
          duration: const Duration(milliseconds: 150));
    } else if (state == PlayPauseButtonState.hold) {
      await playPauseButtonController.play(
          duration: const Duration(milliseconds: 150));
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
          offset: revealAnimation.value,
          child: Material(
            borderRadius:
                BorderRadius.circular(mainViewmodel.restartButtonSize),
            child: InkWell(
              onTap: () async {
                await timeController.playReverse(
                    duration: const Duration(milliseconds: 800));
                timeController.duration = viewmodel.currentTimerDuration;
                viewmodel.turnOffTimer();
                playPauseIconController.playReverse();
                revealController.playReverse(
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
          scale: buttonAnimation.value,
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
