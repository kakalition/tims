import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tims/viewmodels/add_timer_viewmodel.dart';

import '../constants.dart';
import '../utils.dart';

class CircleClock extends StatelessWidget {
  CircleClock({Key? key, required this.viewmodel}) : super(key: key);
  AddTimerVM viewmodel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getCircleClockSize(context),
      width: getCircleClockSize(context),
      decoration: BoxDecoration(
        color: whiteColorDarkTheme,
        borderRadius: BorderRadius.circular(
          getCircleClockSize(context),
        ),
      ),
      child: Center(
          child: Obx(
        () => timsTextBuilder(
            text:
                '${viewmodel.timeDigit[0]}${viewmodel.timeDigit[1]}:${viewmodel.timeDigit[2]}${viewmodel.timeDigit[3]}',
            textSize: 32,
            color: Colors.black),
      )),
    );
  }
}
