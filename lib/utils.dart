import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget timsTextBuilderWithStyle(
    {required String text, required TextStyle textStyle}) {
  return Text(text, style: GoogleFonts.lato(textStyle: textStyle));
}

Widget timsTextBuilder(
    {required String text,
    required double textSize,
    FontWeight fontWeight = FontWeight.w500}) {
  return Text(text,
      style: GoogleFonts.lato(fontSize: textSize, fontWeight: fontWeight));
}
