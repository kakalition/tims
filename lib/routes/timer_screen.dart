import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/enum/viewmodel_source.dart';
import 'package:tims/interfaces/i_clock_component.dart';
import 'package:tims/interfaces/i_clock_mediator.dart';
import 'package:tims/viewmodels/animation_center.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/viewmodels/timer_viewmodel.dart';
import 'package:tims/widgets/play_pause_button.dart';

import '../constants.dart';
import '../utils.dart';
import 'timer_list_screen.dart';

class TimerScreen extends StatelessWidget implements IClockMediator {
  TimerScreen({Key? key}) : super(key: key);
  final TimerVM viewmodel = Get.put(TimerVM());

  @override
  Widget build(BuildContext context) {
    // Timer Screen Layout
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

  @override
  void notify(IClockComponent component, String event) {
    if (component is PlayPauseButton) {
      switch (event) {
        case 'play':
          {
            viewmodel.playClock();
            break;
          }
        case 'stop':
          {
            viewmodel.stopClock();
            break;
          }
        case 'restart':
          {
            viewmodel.restartClock();
            break;
          }
      }
    }
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

class _TimeCircleState extends State<TimeCircle>
    with SingleTickerProviderStateMixin {
  MainVM mainViewmodel = Get.find<MainVM>();
  AnimationCenter animationCenter = Get.find<AnimationCenter>();
  TimerVM viewmodel = Get.find<TimerVM>();

  late AnimationController _clockController;
  late Animation<Duration> _timerTimeAnimation;
  late Animation<double> _timerCircleAnimation;

  @override
  void initState() {
    super.initState();

    // Init animation controller
    _clockController = viewmodel.setClockController(
        AnimationController(duration: const Duration(seconds: 5), reverseDuration: const Duration(milliseconds: 600), vsync: this))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          viewmodel.showNotification(
              mainViewmodel.notificationService, 'Title', 'Body');
        }
      });

    // Init animation
    _timerTimeAnimation = Tween<Duration>(
            begin: viewmodel.currentTimerDuration, end: Duration.zero)
        .animate(_clockController)
      ..addListener(() {
        setState(() {});
      });
    _timerCircleAnimation =
        Tween<double>(begin: 1, end: 0).animate(_clockController)
          ..addListener(() {
            setState(() {});
          });

    // Init time duration
    viewmodel.setTimerDuration();
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
                      value: _timerCircleAnimation.value))
            ],
          ),
          timsTextBuilder(
              text: formattedTimerString(_timerTimeAnimation),
              textSize: 38,
              fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}
