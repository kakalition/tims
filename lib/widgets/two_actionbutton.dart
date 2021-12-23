import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/viewmodels/timer_list_viewmodel.dart';

import '../constants.dart';
import '../utils.dart';

class TwoButton extends StatelessWidget {
  const TwoButton({Key? key, required this.viewmodel}) : super(key: key);
	final TimerListVM viewmodel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
						onTap: () {
							navigator!.pop();
						},
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: timsTextBuilder(
              text: "Cancel",
              color: blackColorWhiteTheme,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: blackColorWhiteTheme,
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            onTap: () {
				      viewmodel.toAddTimer();			
						},
            child: Container(
                alignment: Alignment.center,
								padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                height: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: timsTextBuilder(
                    text: "Continue", color: whiteColorDarkTheme)),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
