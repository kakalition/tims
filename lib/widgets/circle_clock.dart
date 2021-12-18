import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/viewmodels/add_timer_viewmodel.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';

import '../constants.dart';
import '../utils.dart';

class CircleClock extends StatelessWidget {
  CircleClock({Key? key, required this.viewmodel}) : super(key: key);
	final MainVM mainViewmodel =  Get.find<MainVM>();
  final AddTimerVM viewmodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mainViewmodel.circleClockSize,
      width: mainViewmodel.circleClockSize,
      decoration: BoxDecoration(
        color: whiteColorDarkTheme,
        borderRadius: BorderRadius.circular(
          mainViewmodel.circleClockSize,
        ),
      ),
      child: Center(
          child: Obx(
        () => timsTextBuilder(
            text:
                '${viewmodel.timeDigit[0]}${viewmodel.timeDigit[1]}:${viewmodel.timeDigit[2]}${viewmodel.timeDigit[3]}',
            textSize: 28,
            color: Colors.black),
      )),
    );
  }
}
