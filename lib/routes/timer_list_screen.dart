import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/routes/timer_screen.dart';
import 'package:tims/widgets/two_actionbutton.dart';

import '../constants.dart';
import '../utils.dart';

class TimerListScreen extends StatelessWidget {
  TimerListScreen({Key? key}) : super(key: key);
  TimerTypeValue? _radioValue = TimerTypeValue.normal;

  @override
  Widget build(BuildContext context) {
    const double fabSize = 56;
    return Container(
      color: backgroundDarkTheme,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
              itemBuilder: (context, index) => TimerListTile(), itemCount: 10),
          PlayAnimation<double>(
            tween: Tween<double>(begin: -50, end: 60),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            builder: (context, child, value) => Positioned(
              bottom: value,
              child: Material(
                color: whiteColorDarkTheme,
                shape: CircleBorder(),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: whiteColorDarkTheme,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              timsTextBuilder(
                                  text: 'Select Timer Type',
                                  textSize: 26,
                                  color: blackColorWhiteTheme),
                              const SizedBox(
                                height: 20,
                              ),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          setState(
                                            () {
                                              _radioValue =
                                                  TimerTypeValue.normal;
                                            },
                                          );
                                        },
                                        title: timsTextBuilder(
                                            text: 'Normal Timer',
                                            textSize: 20,
                                            color: blackColorWhiteTheme),
                                        leading: Icon(LineIcons.hourglass, size: 36,
                                            color: blackColorWhiteTheme),
                                        trailing: Radio<TimerTypeValue>(
                                          value: TimerTypeValue.normal,
                                          groupValue: _radioValue,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                _radioValue = value;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          setState(
                                            () {
                                              _radioValue =
                                                  TimerTypeValue.interval;
                                            },
                                          );
                                        },
                                        title: timsTextBuilder(
                                            text: 'Interval Timer',
                                            textSize: 20,
                                            color: blackColorWhiteTheme),
                                        leading: Icon(LineIcons.clock, size: 36,
                                            color: blackColorWhiteTheme),
                                        trailing: Radio<TimerTypeValue>(
                                          value: TimerTypeValue.interval,
                                          groupValue: _radioValue,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                _radioValue = value;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(alignment: Alignment.centerRight, child: TwoButton()),
                            ],
                          ),
                        );
                      },
                    );
                  },
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
          ),
        ],
      ),
    );
  }
}

enum TimerTypeValue { normal, interval }

class TimerListTile extends StatelessWidget {
  const TimerListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: whiteColorDarkTheme,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(LineIcons.seedling,
                                  color: blackColorWhiteTheme, size: 32),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            timsTextBuilder(
                                text: 'Use',
                                textSize: 24,
                                color: blackColorWhiteTheme),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: whiteColorDarkTheme,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(LineIcons.pencilRuler,
                                  color: blackColorWhiteTheme, size: 32),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            timsTextBuilder(
                                text: 'Edit',
                                textSize: 24,
                                color: blackColorWhiteTheme),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: whiteColorDarkTheme,
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(LineIcons.trash,
                                  color: blackColorWhiteTheme, size: 32),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            timsTextBuilder(
                                text: 'Delete',
                                textSize: 24,
                                color: blackColorWhiteTheme),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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
