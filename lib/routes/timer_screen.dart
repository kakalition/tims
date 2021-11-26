import 'package:flutter/material.dart';
import 'package:tims/constants.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              border: Border.all(width: 6, color: whiteColorDarkTheme),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.4,
              )),
        )
      ],
    );
  }
}
