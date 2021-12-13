import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/viewmodels/add_timer_viewmodel.dart';
import 'package:tims/widgets/circle_clock.dart';

import '../constants.dart';
import '../utils.dart';

class AddIntervalTimer extends StatelessWidget {
  AddIntervalTimer({Key? key}) : super(key: key);
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
          "Add Interval Timer",
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
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
            const SizedBox(
              height: 40,
            ),
            CircleClock(
              viewmodel: viewmodel,
            ),
            const SizedBox(
              height: 20,
            ),
            timsTextBuilder(text: 'Total Time', textSize: 24),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        timsTextBuilder(text: 'Interval List', textSize: 24),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Container(
                      height: 44,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: timsTextBuilder(
                            text: "Cancel",
                            textSize: 18,
                            color: whiteColorDarkTheme),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Material(
                    color: whiteColorDarkTheme,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {},
                      child: Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: timsTextBuilder(
                              text: "Confirm",
                              textSize: 18,
                              color: blackColorWhiteTheme),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
