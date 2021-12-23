import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/viewmodel_source.dart';
import 'package:tims/viewmodels/animation_center.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/viewmodels/timer_viewmodel.dart';
import 'package:tims/widgets/play_pause_button.dart';

import '../constants.dart';
import '../utils.dart';
import 'timer_list_screen.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerVM viewmodel = Get.put(TimerVM());
    
		// Timer Screen Layout
    return Container(
      color: backgroundDarkTheme,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
						const SizedBox(height:20),
						const Spacer(),
            const TimeCircle(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
							height: MediaQuery.of(context).size.height * 0.27,
							child: const PlayPauseButton(source: ViewmodelSource.timer)),
						const Spacer(),
            const TimerListTile(),
						const SizedBox(height:20),
          ],
        ),
      ),
    );
  }

}

// Circle in Timer Screen
class TimeCircle extends StatefulWidget {
  const TimeCircle({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeCircle> createState() => _TimeCircleState();
}

class _TimeCircleState extends State<TimeCircle> with AnimationMixin {
	MainVM mainViewmodel = Get.find<MainVM>();
	AnimationCenter animationCenter = Get.find<AnimationCenter>();
  TimerVM viewmodel = Get.find<TimerVM>();

  @override
  void initState() {
    super.initState();
		if(animationCenter.getAnimationController(TimsAnimation.timerCircle) == null) {
			animationCenter.setAnimationController(TimsAnimation.timerCircle, createController());
			animationCenter.setAnimationController(TimsAnimation.timerTime, createController());
			animationCenter.initTimerAnimation();
		}
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mainViewmodel.circleTimerSize,
      width: mainViewmodel.circleTimerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
								height: mainViewmodel.circleTimerSize,
								width: mainViewmodel.circleTimerSize,
                child: const CircularProgressIndicator(
                    color: Color(0xFF212121), strokeWidth: 10, value: 1),
              ),
              SizedBox(
								height: mainViewmodel.circleTimerSize,
								width: mainViewmodel.circleTimerSize,
                child: CircularProgressIndicator(
                    color: whiteColorDarkTheme,
                    strokeWidth: 10,
                    value:animationCenter.getAnimation(TimsAnimation.timerCircle)!.value),
              )
            ],
          ),
          timsTextBuilder(
              text: formattedTimerString(animationCenter.getAnimation(TimsAnimation.timerTime)!),
              textSize: 38,
              fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}

