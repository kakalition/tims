import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/constants.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Time Circle
          Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width * 0.65,
              width: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                border: Border.all(width: 12, color: whiteColorDarkTheme),
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.65,
                ),
              ),
              child: Text(
                "00:24:00",
                style: GoogleFonts.montserrat(fontSize: 34),
              )),
          const SizedBox(
            height: 30,
          ),

          // Play/Stop Button
          Material(
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.65 / 1.618 / 1.5),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.65 / 1.618 / 1.5),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.65 / 1.618 / 1.5,
                width: MediaQuery.of(context).size.width * 0.65 / 1.618 / 1.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.65 / 1.618 / 1.5,
                  ),
                ),
                child: Icon(
                  LineIcons.play,
                  color: whiteColorDarkTheme,
                  size: MediaQuery.of(context).size.width * 0.125,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          // Restart Button
          Material(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.18),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.18),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.18,
                width: MediaQuery.of(context).size.width * 0.18,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.18,
                  ),
                ),
                child: Icon(
                  Icons.replay,
                  color: whiteColorDarkTheme,
                  size: MediaQuery.of(context).size.width * 0.08,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),

          // FAB
          Material(
            color: whiteColorDarkTheme,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.12),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.12),
              child: Container(
                  height: MediaQuery.of(context).size.width * 0.12,
                  width: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.12,
                    ),
                  ),
                  child: Icon(
                    LineIcons.plus,
                    color: blackColorWhiteTheme,
                    size: MediaQuery.of(context).size.width * 0.06,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
