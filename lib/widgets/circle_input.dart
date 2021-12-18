import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/viewmodels/add_timer_viewmodel.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';

import '../utils.dart';
import '../constants.dart';

class ClockInput extends StatelessWidget {
  ClockInput({Key? key, required this.timeDigit}) : super(key: key);
  final RxList<int> timeDigit;
	final MainVM mainViewmodel = Get.find<MainVM>();
  final AddTimerVM viewmodel = Get.find<AddTimerVM>();

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
            DigitPiece(
              digit: '1',
              fun: viewmodel.clickDigit(1),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              digit: '2',
              fun: viewmodel.clickDigit(2),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              digit: '3',
              fun: viewmodel.clickDigit(3),
            )
          ],
        ),
        SizedBox(height: mainViewmodel.digitSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DigitPiece(
              digit: '4',
              fun: viewmodel.clickDigit(4),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              digit: '5',
              fun: viewmodel.clickDigit(5),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              digit: '6',
              fun: viewmodel.clickDigit(6),
            )
          ],
        ),
        SizedBox(height: mainViewmodel.digitSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DigitPiece(
              digit: '7',
              fun: viewmodel.clickDigit(7),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              digit: '8',
              fun: viewmodel.clickDigit(8),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              digit: '9',
              fun: viewmodel.clickDigit(9),
            )
          ],
        ),
        SizedBox(height: mainViewmodel.digitSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DigitPiece(
              icon: LineIcons.backspace,
              color: whiteColorDarkTheme,
              fun: viewmodel.deleteDigit(),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              digit: '0',
              fun: viewmodel.clickDigit(0),
            ),
            SizedBox(width: mainViewmodel.digitSpacing),
            DigitPiece(
              icon: LineIcons.check,
              color: whiteColorDarkTheme,
              fun: viewmodel.clickDigit(1),
            )
          ],
        )
      ],
    );
  }
}

class DigitPiece extends StatelessWidget {
  DigitPiece({
    Key? key,
    this.digit,
    this.icon,
    required this.fun,
    this.color = const Color(0xFF343434),
  }) : super(key: key);
	final MainVM mainViewmodel = Get.find<MainVM>();
  final String? digit;
  final IconData? icon;
  final Color color;
  final void Function() fun;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(
        mainViewmodel.digitPieceSize,
      ),
      child: InkWell(
        onTap: () {
          fun();
        },
        borderRadius: BorderRadius.circular(
          mainViewmodel.digitPieceSize,
        ),
        child: InkWell(
          child: Container(
            height: mainViewmodel.digitPieceSize,
            width: mainViewmodel.digitPieceSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                mainViewmodel.digitPieceSize,
              ),
            ),
            child: icon == null
                ? Center(child: timsTextBuilder(text: digit!, textSize: 28))
                : Center(
                    child: Icon(icon, size: 28, color: blackColorWhiteTheme),
                  ),
          ),
        ),
      ),
    );
  }
}
