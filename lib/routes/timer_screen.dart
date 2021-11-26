import 'package:flutter/material.dart';
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
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              border: Border.all(width: 12, color: whiteColorDarkTheme),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.6,
              ),
            ),
          ),

          // Play/Stop Button
          Container(
            height: MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              border: Border.all(width: 6, color: whiteColorDarkTheme),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.3,
              ),
            ),
          ),

          // Restart Button
          Container(
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              border: Border.all(width: 6, color: whiteColorDarkTheme),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.25,
              ),
            ),
          ),

          // FAB
          Material(
            color: whiteColorDarkTheme,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.25),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.2),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
