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

// Formatted Timer String
String formattedTimerString(Animation animation) =>
		"${(animation.value as Duration).inMinutes.toString().padLeft(2, '0')}:${((animation.value as Duration).inSeconds % 60).toString().padLeft(2, '0')}";
