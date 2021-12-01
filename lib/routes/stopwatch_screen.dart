import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../constants.dart';
import '../utils.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double timerCircleSize = getCircleTimerSize(context);
    final double playButtonSize = timerCircleSize / 1.618 / 1.5;
    final double restartButtonSize = playButtonSize / 1.618;
    final double playIconSize = playButtonSize * 0.4;
    final double restartIconSize = restartButtonSize * 0.4;

    return Container(
      color: backgroundDarkTheme,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Time Circle
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: timerCircleSize,
                  width: timerCircleSize,
                  decoration: BoxDecoration(
                    border: Border.all(width: 12, color: Color(0xFF212121)),
                    borderRadius: BorderRadius.circular(
                      timerCircleSize,
                    ),
                  ),
                  child: Text(
                    "00:00:00",
                    style: GoogleFonts.montserrat(fontSize: 34),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: whiteColorDarkTheme,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
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
      ),
    );
  }
}
