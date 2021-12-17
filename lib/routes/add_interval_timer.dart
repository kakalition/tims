import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/viewmodels/add_timer_viewmodel.dart';
import 'package:tims/widgets/circle_clock.dart';

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
				actions: [
          IconButton(
            onPressed: () {
              navigator!.pop();
            },
            icon: const Icon(LineIcons.check)),
					const SizedBox(width: 5),
				],
        centerTitle: true,
        title: Text(
          "Add Interval Timer",
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
				height: MediaQuery.of(context).size.height * 0.88,
				width: MediaQuery.of(context).size.width,
				padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                decoration: InputDecoration(
                  label: timsTextBuilder(text: "Timer Name", textSize: 16),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CircleClock(
                viewmodel: viewmodel,
              ),
              const SizedBox(
                height: 15,
              ),
              timsTextBuilder(text: 'Total Time', textSize: 24),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 5),
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
                          Material(
													color: Colors.transparent,
													borderRadius: BorderRadius.circular(40),
                            child: InkWell(
													onTap: () {},
													borderRadius: BorderRadius.circular(40),
                              child: Container( height: 40, width: 40, child: const Icon(Icons.close)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
