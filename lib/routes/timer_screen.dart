import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/constants.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double timerCircleSize = getCircleTimerSize(context);
    final double playButtonSize = timerCircleSize / 1.618 / 1.5;
    final double restartButtonSize = playButtonSize / 1.618;
    final double playIconSize = playButtonSize * 0.4;
    final double restartIconSize = restartButtonSize * 0.4;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Time Circle
          Container(
              alignment: Alignment.center,
              height: timerCircleSize,
              width: timerCircleSize,
              decoration: BoxDecoration(
                border: Border.all(width: 12, color: whiteColorDarkTheme),
                borderRadius: BorderRadius.circular(
                  timerCircleSize,
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
            borderRadius: BorderRadius.circular(playButtonSize),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(playButtonSize),
              child: Container(
                height: playButtonSize,
                width: playButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    playButtonSize,
                  ),
                ),
                child: Icon(
                  LineIcons.play,
                  color: whiteColorDarkTheme,
                  size: playIconSize,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          // Restart Button
          Material(
            borderRadius: BorderRadius.circular(restartButtonSize),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(restartButtonSize),
              child: Container(
                height: restartButtonSize,
                width: restartButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    restartButtonSize,
                  ),
                ),
                child: Icon(
                  Icons.replay,
                  color: whiteColorDarkTheme,
                  size: restartIconSize,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}

double getCircleTimerSize(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.65;
