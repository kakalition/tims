import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/playpause_button_state.dart';
import 'package:tims/viewmodels/timer_viewmodel.dart';

import '../constants.dart';
import '../utils.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerVM viewmodel = Get.put(TimerVM());
    final double timerCircleSize = getCircleTimerSize(context);
    final double playButtonSize = timerCircleSize / 1.618 / 1.5;
    final double restartButtonSize = playButtonSize / 1.618;
    final double playIconSize = playButtonSize * 0.4;
    final double restartIconSize = restartButtonSize * 0.4;

    return Container(
      color: backgroundDarkTheme,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Time Circle
            Container(
                alignment: Alignment.center,
                height: timerCircleSize,
                width: timerCircleSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 12, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    timerCircleSize,
                  ),
                ),
                child: TimerText()),
            const SizedBox(
              height: 30,
            ),

            Container(
                height: MediaQuery.of(context).size.height * 0.27,
                child: const PlayPauseButton()),

            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> with AnimationMixin {
  TimerVM viewmodel = Get.find<TimerVM>();
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
    revealAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0, 160))
        .animate(revealController.drive(CurveTween(curve: Curves.easeOut)));
    timeAnimation = viewmodel.getTimerTween().animate(timeController);
    timeController.duration = viewmodel.currentTimerDuration;
    super.didChangeDependencies();
  }

  void animateButton(PlayPauseButtonState state) async {
    if (state == PlayPauseButtonState.tap) {
      viewmodel.toggleTimer();
      if (viewmodel.isTimerActive.value) {
        timeController.forward();
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

class TimerText extends StatefulWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> with AnimationMixin {
  TimerVM viewmodel = Get.find<TimerVM>();

  @override
  void initState() {
    super.initState();
    viewmodel.setTimeController(controller);
  }

  @override
  Widget build(BuildContext context) {
    return timsTextBuilder(
        text: viewmodel.formattedTimerString(
            viewmodel.getTimerTween().animate(controller)),
        textSize: 38,
        fontWeight: FontWeight.w400);
  }
}
