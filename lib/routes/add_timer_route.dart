import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../utils.dart';

class AddTimerRoute extends StatelessWidget {
  const AddTimerRoute({Key? key}) : super(key: key);

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
          "Add Timer",
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(60),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(alignment: Alignment.center, children: [
                Material(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF434343),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      navigator!.pushNamed('/addnormaltimer');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(LineIcons.hourglass, size: 96),
                      const SizedBox(
                        height: 20,
                      ),
                      timsTextBuilder(text: "Normal", textSize: 36),
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Stack(alignment: Alignment.center, children: [
                Material(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF434343),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(LineIcons.clock, size: 96),
                      const SizedBox(
                        height: 20,
                      ),
                      timsTextBuilder(text: "Interval", textSize: 32),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
