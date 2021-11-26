import 'package:flutter/material.dart';
import 'package:tims/constants.dart';
import 'package:tims/utils.dart';

class NavigationDrawerTile extends StatelessWidget {
  NavigationDrawerTile({Key? key, required this.icon, required this.tileLabel})
      : super(key: key);
  IconData icon;
  String tileLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: drawerTileDarkTheme,
      borderRadius: BorderRadius.circular(55),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(55),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(55)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 55,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center, child: Icon(icon, size: 32)),
                  const SizedBox(
                    width: 5,
                  ),
                  timsTextBuilder(text: tileLabel, textSize: 18)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
