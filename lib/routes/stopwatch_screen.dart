import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/utils.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/viewmodels/stopwatch_viewmodel.dart';
import 'package:tims/widgets/play_pause_button.dart';

import '../constants.dart';
import 'timer_list_screen.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: PlayPauseButton(viewmodel: Get.find<StopwatchVM>())),
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

class _StopwatchCircleState extends State<StopwatchCircle> with TickerProviderStateMixin{
	MainVM mainViewmodel = Get.find<MainVM>();
	StopwatchVM viewmodel = Get.put(StopwatchVM());

	late AnimationController _timeController;
	late AnimationController _circleController;
	late Animation<Duration> _stopwatchTimeAnimation;
	late Animation<double> _stopwatchCircleAnimation;

  @override
  void initState() {
    super.initState();

		// Init animation controller
	  _timeController = viewmodel.setTimeController(
        AnimationController(duration: const Duration(days: 31), reverseDuration: const Duration(milliseconds: 600), vsync: this));
	  _circleController = viewmodel.setCircleController(
        AnimationController(duration: const Duration(milliseconds: 1500), reverseDuration: const Duration(milliseconds: 600), vsync: this));
		
		// Init animation
		_stopwatchTimeAnimation = Tween<Duration>(begin: Duration.zero, end: const Duration(days: 31))
				.animate(_timeController)
      ..addListener(() {
        setState(() {});
      });
		_stopwatchCircleAnimation = Tween<double>(begin: 0, end: 2)
				.animate(_circleController)
      ..addListener(() {
        setState(() {});
      });
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
        ),
        Transform.rotate(
          angle: math.pi * _stopwatchCircleAnimation.value,
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
				timsTextBuilder(
						text: formattedTimerString(_stopwatchTimeAnimation),
						textSize: 38,
						fontWeight: FontWeight.w400),
      ],
    );
  }
}

