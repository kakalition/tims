import 'package:flutter/material.dart';

import '../constants.dart';
import '../utils.dart';

class CircleClock extends StatelessWidget {
  CircleClock({Key? key, required this.timeDigit}) : super(key: key);
  List<int> timeDigit;

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
        child: timsTextBuilder(
            text: "00:00", textSize: 48, color: blackColorWhiteTheme),
      ),
    );
  }
}
