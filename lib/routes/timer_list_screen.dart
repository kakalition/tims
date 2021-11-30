import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../constants.dart';
import '../utils.dart';

class TimerListScreen extends StatelessWidget {
  const TimerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fabSize = MediaQuery.of(context).size.width * 0.12;
    return Stack(
      alignment: Alignment.center,
      children: [
        ListView.builder(
            itemBuilder: (context, index) => TimerListTile(), itemCount: 10),
        Positioned(
          right: 30,
          bottom: 30,
          child: Material(
            color: whiteColorDarkTheme,
            shape: CircleBorder(),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(fabSize),
              child: Container(
                height: fabSize,
                width: fabSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(fabSize),
                ),
                child: Icon(LineIcons.plus,
                    color: blackColorWhiteTheme, size: fabSize / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimerListTile extends StatelessWidget {
  const TimerListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(4),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 12, right: 12, bottom: 12, left: 4),
              child: Icon(LineIcons.hourglass, size: 56),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                timsTextBuilder(
                    text: 'Study Timer',
                    textSize: 24,
                    fontWeight: FontWeight.w500),
                timsTextBuilder(
                    text: '24:00', textSize: 18, fontWeight: FontWeight.w300),
              ],
            )
          ],
        ),
      ),
    );
  }
}
