import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tims/viewmodels/timer_list_viewmodel.dart';
import 'package:tims/widgets/two_actionbutton.dart';

import '../constants.dart';
import '../utils.dart';

class TimerListScreen extends StatelessWidget {
  TimerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerListVM viewmodel = Get.put(TimerListVM());
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
                          padding: EdgeInsets.symmetric(vertical: 20),
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
                              TimerRadio(viewmodel: viewmodel)
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

class TimerRadio extends StatelessWidget {
  const TimerRadio({
    Key? key, required this.viewmodel
  }) : super(key: key);
	final TimerListVM viewmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx( 
          () => ListTile(
            onTap: () {
						viewmodel.setRadioValue(TimerTypeValue.normal);
					},
            title: timsTextBuilder(
                text: 'Normal Timer', textSize: 20, color: blackColorWhiteTheme),
            leading:
                Icon(LineIcons.hourglass, size: 36, color: blackColorWhiteTheme),
            trailing: Radio<TimerTypeValue>(
              value: TimerTypeValue.normal,
              groupValue: viewmodel.currentRadioValue.value,
              onChanged: (value) {
							viewmodel.setRadioValue(value);
						},
            ),
          ),
        ),
        Obx(
          () => ListTile(
            onTap: () {
						viewmodel.setRadioValue(TimerTypeValue.interval);
					},
            title: timsTextBuilder(
                text: 'Interval Timer',
                textSize: 20,
                color: blackColorWhiteTheme),
            leading: Icon(LineIcons.clock, size: 36, color: blackColorWhiteTheme),
            trailing: Radio<TimerTypeValue>(
              value: TimerTypeValue.interval,
              groupValue: viewmodel.currentRadioValue.value,
              onChanged: (value) {
							viewmodel.setRadioValue(value);
						},
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Align(alignment: Alignment.centerRight, child: TwoButton(viewmodel: viewmodel)),
          const SizedBox(width: 10)
        ]),
      ],
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
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
                        margin: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Icon(LineIcons.seedling,
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
                        margin: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Icon(LineIcons.pencilRuler,
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
                        margin: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Icon(LineIcons.trash,
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
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
				width: MediaQuery.of(context).size.width,
				decoration: BoxDecoration(color: const Color(0xFF212121), borderRadius: BorderRadius.circular(16)),
        child: Row(
					mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 12, right: 0, bottom: 16, left: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  timsTextBuilder(
                      text: 'Study Timer',
                      textSize: 22,
                      fontWeight: FontWeight.w500),
                  timsTextBuilder(
                      text: '24:00', textSize: 16, fontWeight: FontWeight.w300),
                ],
              ),
            ),
						const Spacer(),
            Container(
						  alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12, left: 0),
              child: const Icon(LineIcons.hourglass, size: 48),
            ),
          ],
        ),
      ),
    );
  }
}
