import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/constants.dart';

class SplashRoute extends StatelessWidget {
  const SplashRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Get.offNamed('/main'));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text('TIMS',
                style: GoogleFonts.montserrat(
                    color: whiteColorDarkTheme,
                    fontSize: MediaQuery.of(context).size.width * 0.2,
                    fontWeight: FontWeight.w200)),
            const Spacer(),
            Icon(LineIcons.hourglass,
                color: whiteColorDarkTheme,
                size: MediaQuery.of(context).size.width * 0.12),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
