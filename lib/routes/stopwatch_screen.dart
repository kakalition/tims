import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/viewmodel_source.dart';
import 'package:tims/viewmodels/animation_center.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/viewmodels/stopwatch_viewmodel.dart';
import 'package:tims/widgets/play_pause_button.dart';
import 'dart:math' as math;

import '../constants.dart';
import 'timer_list_screen.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StopwatchVM viewmodel = Get.put(StopwatchVM());

    return Container(
      color: backgroundDarkTheme,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Time Circle
            const StopwatchCircle(),
            const SizedBox(
              height: 30,
            ),
            // Play/Stop Button
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                child: const PlayPauseButton(source: ViewmodelSource.stopwatch)),
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
  }) : super(key: key);

  @override
  State<StopwatchCircle> createState() => _StopwatchCircleState();
}

class _StopwatchCircleState extends State<StopwatchCircle> with AnimationMixin {
	MainVM mainViewmodel = Get.find<MainVM>();
	AnimationCenter animationCenter = Get.find<AnimationCenter>();
	StopwatchVM viewmodel = Get.put(StopwatchVM());

  @override
  void initState() {
    super.initState();
		animationCenter.setAnimationController(TimsAnimation.stopwatchCircle, createController());
		animationCenter.setAnimationController(TimsAnimation.stopwatchTime, createController());
		animationCenter.initStopwatchAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: mainViewmodel.circleTimerSize,
          width: mainViewmodel.circleTimerSize,
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: const Color(0xFF212121)),
            borderRadius: BorderRadius.circular(mainViewmodel.circleTimerSize),
          ),
          child: Text(
            "00:00:00",
            style: GoogleFonts.montserrat(fontSize: 34),
          ),
        ),
        Transform.rotate(
          angle: math.pi * animationCenter.getAnimation(TimsAnimation.stopwatchCircle)!.value,
          child: Container(
            height: mainViewmodel.circleTimerSize,
            width: mainViewmodel.circleTimerSize,
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
