import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/enum/viewmodel_source.dart';
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
    
    return Container(
      color: backgroundDarkTheme,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const TimeCircle(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
							height: MediaQuery.of(context).size.height * 0.27,
							child: const PlayPauseButton(source: ViewmodelSource.timer)),
						const Align(
							alignment: Alignment.bottomCenter,
							child: TimerListTile(),
						)
          ],
        ),
      ),
    );
  }

}

class TimeCircle extends StatefulWidget {
  const TimeCircle({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeCircle> createState() => _TimeCircleState();
}

class _TimeCircleState extends State<TimeCircle> with AnimationMixin {
	MainVM mainViewmodel = Get.find<MainVM>();
  TimerVM viewmodel = Get.find<TimerVM>();
  late Animation circleAnimation;

  @override
  void initState() {
    super.initState();
    viewmodel.setTimeController(controller);
    circleAnimation =
        Tween<double>(begin: 1, end: 0).animate(viewmodel.getTimeController());
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
                    value: circleAnimation.value),
              )
            ],
          ),
          timsTextBuilder(
              text: viewmodel.formattedTimerString(
                  viewmodel.getTimerTween().animate(controller)),
              textSize: 38,
              fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}
