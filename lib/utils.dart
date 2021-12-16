import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

Widget timsTextBuilderWithStyle(
    {required String text, required TextStyle textStyle}) {
  return Text(text, style: GoogleFonts.lato(textStyle: textStyle));
}

Widget timsTextBuilder(
    {required String text,
    double textSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    Color color = whiteColorDarkTheme}) {
  return Text(text,
      style: GoogleFonts.lato(
          fontSize: textSize, fontWeight: fontWeight, color: color));
}

double getCircleTimerSize(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.62;

double getCircleClockSize(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.3;
