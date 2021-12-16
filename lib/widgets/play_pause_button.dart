import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/playpause_button_state.dart';
import 'package:tims/enum/viewmodel_source.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/viewmodels/stopwatch_viewmodel.dart';
import 'package:tims/viewmodels/timer_viewmodel.dart';

import '../constants.dart';
import '../utils.dart';

class PlayPauseButton extends StatefulWidget {
  PlayPauseButton({Key? key, required this.source}) : super(key: key);
  ViewmodelSource source;

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with AnimationMixin {
  dynamic viewmodel;
  late final double timerCircleSize;
  late final double playButtonSize;
  late final double playIconSize;
  late final double restartButtonSize;
  late final double restartIconSize;

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
    playPauseButtonController = createController();
    playPauseIconController = createController();
    revealController = createController();
    if (widget.source == ViewmodelSource.timer) {
      viewmodel = Get.find<TimerVM>();
      debugPrint(viewmodel.toString());
    } else if (widget.source == ViewmodelSource.stopwatch) {
      viewmodel = Get.find<StopwatchVM>();
    }
    timeController = viewmodel.getTimeController();
  }

  @override
  void didChangeDependencies() {
    timerCircleSize = getCircleTimerSize(context);
    playButtonSize = timerCircleSize / 1.618 / 1.5;
    playIconSize = playButtonSize * 0.5;
    restartButtonSize = playButtonSize / 1.618;
    restartIconSize = restartButtonSize * 0.4;
    buttonAnimation =
        Tween<double>(begin: 1, end: 1.05).animate(playPauseButtonController);
    iconButtonAnimation = Tween<double>(begin: 0, end: 1)
        .animate(playPauseIconController)
        .drive(CurveTween(curve: Curves.easeOut));
    revealAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0, MediaQuery.of(context).size.height * 0.2))
        .animate(revealController.drive(CurveTween(curve: Curves.easeOut)));
    if (widget.source == ViewmodelSource.timer) {
      timeAnimation = viewmodel.getTimerTween().animate(timeController);
    }
    if (widget.source == ViewmodelSource.timer) {
      timeController.duration = viewmodel.currentTimerDuration;
    } else if (widget.source == ViewmodelSource.stopwatch) {
      timeController.duration = Duration(milliseconds: 1500);
    }

    super.didChangeDependencies();
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
            borderRadius: BorderRadius.circular(restartButtonSize),
            child: InkWell(
              onTap: () {
                timeController.reset();
                viewmodel.turnOffTimer();
                playPauseIconController.playReverse();
                revealController.playReverse(
                    duration: const Duration(milliseconds: 300));
              },
              borderRadius: BorderRadius.circular(restartButtonSize),
              child: Container(
                height: restartButtonSize,
                width: restartButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    restartButtonSize,
                  ),
                ),
                child: Icon(
                  Icons.replay,
                  color: whiteColorDarkTheme,
                  size: restartIconSize,
                ),
              ),
            ),
          ),
        ),
        // Play/Stop Button
        Transform.scale(
          scale: buttonAnimation.value,
          child: Material(
            borderRadius: BorderRadius.circular(playButtonSize),
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
              borderRadius: BorderRadius.circular(playButtonSize),
              child: Container(
                height: playButtonSize,
                width: playButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    playButtonSize,
                  ),
                ),
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: playPauseIconController,
                    color: whiteColorDarkTheme,
                    size: playIconSize,
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
