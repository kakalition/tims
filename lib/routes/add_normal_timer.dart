import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/viewmodels/add_timer_viewmodel.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/widgets/circle_clock.dart';
import 'package:tims/widgets/circle_input.dart';

import '../utils.dart';
import '../constants.dart';

class AddNormalTimer extends StatelessWidget {
  AddNormalTimer({Key? key}) : super(key: key);
	final MainVM mainViewmodel = Get.find<MainVM>();
  final AddTimerVM viewmodel = Get.put(AddTimerVM());

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
      body: SingleChildScrollView(
        child: Container(
					height: mainViewmodel.scrollableHeight,
					width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 5, left: 20, bottom: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                decoration: InputDecoration(
							contentPadding: const EdgeInsets.all(8),
                  label: timsTextBuilder(text: "Timer Name", textSize: 16),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
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
            ],
          ),
        ),
      ),
    );
  }
}
