import 'package:flutter/material.dart';

import '../utils.dart';

class CircleInput extends StatelessWidget {
  CircleInput({Key? key, required this.timeDigit}) : super(key: key);
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
          children: [],
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
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(40),
        ),
        child: icon == null
            ? timsTextBuilder(text: digit!, textSize: 16)
            : Icon(icon, size: 24));
  }
}
