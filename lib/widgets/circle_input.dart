import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../utils.dart';

class ClockInput extends StatelessWidget {
  ClockInput({Key? key, required this.timeDigit}) : super(key: key);
  List<int> timeDigit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DigitPiece(digit: '1'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(digit: '2'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(digit: '3')
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DigitPiece(digit: '4'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(digit: '5'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(digit: '6')
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DigitPiece(digit: '7'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(digit: '8'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(digit: '9')
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DigitPiece(icon: LineIcons.backspace),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(digit: '0'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            DigitPiece(icon: LineIcons.check)
          ],
        )
      ],
    );
  }
}

class DigitPiece extends StatelessWidget {
  DigitPiece({Key? key, this.digit, this.icon}) : super(key: key);
  String? digit;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.17,
      width: MediaQuery.of(context).size.width * 0.17,
      decoration: BoxDecoration(
        color: Color(0xFF343434),
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.17,
        ),
      ),
      child: icon == null
          ? Center(child: timsTextBuilder(text: digit!, textSize: 28))
          : Center(
              child: Icon(icon, size: 42),
            ),
    );
  }
}
