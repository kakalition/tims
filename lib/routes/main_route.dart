import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tims/routes/stopwatch_screen.dart';

import '../constants.dart';
import '../utils.dart';
import 'timer_screen.dart';

class MainRoute extends StatelessWidget {
  MainRoute({Key? key}) : super(key: key);
  List<Widget> screens = [const TimerScreen(), const StopwatchScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Study Timer",
            style: GoogleFonts.montserrat(fontSize: 20),
          ),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(LineIcons.gripLines),
            );
          }),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(LineIcons.cog))
          ],
        ),
        drawer: _MainRouteDrawer(),
        body: screens[1]);
  }
}

class _MainRouteDrawer extends StatelessWidget {
  const _MainRouteDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 1),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LineIcons.userCircleAlt, size: 100),
                  const SizedBox(height: 50),
                  timsTextBuilder(
                      text: "Kaka", textSize: 24, fontWeight: FontWeight.w600),
                  const SizedBox(height: 10),
                  timsTextBuilder(
                      text: "Ambition bring success",
                      textSize: 18,
                      fontWeight: FontWeight.w400),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: NavigationDrawerTile(
                      icon: LineIcons.clock,
                      tileLabel: 'Timer',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: NavigationDrawerTile(
                      icon: LineIcons.flag,
                      tileLabel: 'Stopwatch',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: NavigationDrawerTile(
                      icon: LineIcons.list,
                      tileLabel: 'Timer List',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: NavigationDrawerTile(
                      icon: LineIcons.history,
                      tileLabel: 'History',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
