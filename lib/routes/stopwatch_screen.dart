import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/viewmodel_source.dart';
import 'package:tims/viewmodels/stopwatch_viewmodel.dart';
import 'package:tims/widgets/play_pause_button.dart';
import 'dart:math' as math;

import '../constants.dart';
import '../utils.dart';
import 'timer_list_screen.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StopwatchVM viewmodel = Get.put(StopwatchVM());
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
            StopwatchCircle(timerCircleSize: timerCircleSize),
            const SizedBox(
              height: 30,
            ),
            // Play/Stop Button
            Container(
                height: MediaQuery.of(context).size.height * 0.27,
                child: PlayPauseButton(source: ViewmodelSource.stopwatch)),
						const TimerListTile(),
          ],
        ),
      ),
    );
  }
}

class StopwatchCircle extends StatefulWidget {
  const StopwatchCircle({
    Key? key,
    required this.timerCircleSize,
  }) : super(key: key);

  final double timerCircleSize;

  @override
  State<StopwatchCircle> createState() => _StopwatchCircleState();
}

class _StopwatchCircleState extends State<StopwatchCircle> with AnimationMixin {
  late Animation circleAnimation;

  @override
  void initState() {
    super.initState();
    circleAnimation = Tween<double>(begin: 0, end: 2).animate(controller);
    Get.find<StopwatchVM>().setTimeController(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.timerCircleSize,
          width: widget.timerCircleSize,
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Color(0xFF212121)),
            borderRadius: BorderRadius.circular(
              widget.timerCircleSize,
            ),
          ),
          child: Text(
            "00:00:00",
            style: GoogleFonts.montserrat(fontSize: 34),
          ),
        ),
        Transform.rotate(
          angle: math.pi * circleAnimation.value,
          child: Container(
            height: widget.timerCircleSize,
            width: widget.timerCircleSize,
            alignment: Alignment.topCenter,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: whiteColorDarkTheme,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
