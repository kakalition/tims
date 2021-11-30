import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../utils.dart';
import '/widgets/navigation_drawer_tile.dart';
import 'timer_screen.dart';

class MainRoute extends StatelessWidget {
  MainRoute({Key? key}) : super(key: key);
  List<Widget> screens = [const TimerScreen()];

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
        body: screens[0]);
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
