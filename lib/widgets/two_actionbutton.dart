import 'package:flutter/material.dart';

import '../constants.dart';
import '../utils.dart';

class TwoButton extends StatelessWidget {
  const TwoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: timsTextBuilder(
            text: "Cancel",
            color: blackColorWhiteTheme,
          ),
        ),
        const SizedBox(width: 20),
        Material(
          color: blackColorWhiteTheme,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            onTap: () {},
            child: Container(
                alignment: Alignment.center,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: timsTextBuilder(
                    text: "Next", color: whiteColorDarkTheme)),
          ),
        ),
      ],
    );
  }
}
