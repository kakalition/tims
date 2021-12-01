import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../constants.dart';
import '../utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundDarkTheme,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return HistoryTile();
        },
        itemCount: 10,
      ),
    );
  }
}

class HistoryTile extends StatelessWidget {
  const HistoryTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.close),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
