import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/viewmodels/add_timer_viewmodel.dart';
import 'package:tims/widgets/circle_clock.dart';
import 'package:tims/widgets/circle_input.dart';

import '../utils.dart';
import '../constants.dart';

class AddNormalTimer extends StatelessWidget {
  AddNormalTimer({Key? key}) : super(key: key);
  AddTimerVM viewmodel = Get.put(AddTimerVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: const Icon(LineIcons.arrowLeft)),
        centerTitle: true,
        title: Text(
          "Add Normal Timer",
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              decoration: InputDecoration(
                label: timsTextBuilder(text: "Timer Name", textSize: 16),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
                ),
              ),
            ),
            const Spacer(),
            CircleClock(
              viewmodel: viewmodel,
            ),
            const Spacer(),
            ClockInput(
              timeDigit: viewmodel.timeDigit,
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          ],
        ),
      ),
    );
  }
}
