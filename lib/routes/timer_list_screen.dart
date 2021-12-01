import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:simple_animations/simple_animations.dart';

import '../constants.dart';
import '../utils.dart';

class TimerListScreen extends StatelessWidget {
  const TimerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fabSize = MediaQuery.of(context).size.width * 0.12;
    return Container(
      color: backgroundDarkTheme,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
              itemBuilder: (context, index) => TimerListTile(), itemCount: 10),
          TimerListFAB(fabSize: fabSize),
        ],
      ),
    );
  }
}

class TimerListFAB extends StatefulWidget {
  TimerListFAB({
    Key? key,
    required this.fabSize,
  }) : super(key: key);

  final double fabSize;
  final _TimerListFABState _state = _TimerListFABState();

  @override
  State<TimerListFAB> createState() => _TimerListFABState();
}

class _TimerListFABState extends State<TimerListFAB> with AnimationMixin {
  late Animation fabTranslate;

  @override
  void initState() {
    super.initState();
    fabTranslate = Tween<double>(begin: -10, end: 30)
        .animate(controller.drive(CurveTween(curve: Curves.easeIn)));
    controller.play(duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 30,
      bottom: fabTranslate.value,
      child: Material(
        color: whiteColorDarkTheme,
        shape: CircleBorder(),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(widget.fabSize),
          child: Container(
            height: widget.fabSize,
            width: widget.fabSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.fabSize),
            ),
            child: Icon(LineIcons.plus,
                color: blackColorWhiteTheme, size: widget.fabSize / 2),
          ),
        ),
      ),
    );
  }
}

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
