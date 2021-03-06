import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:tims/routes/history_screen.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';
import 'package:tims/routes/stopwatch_screen.dart';
import 'package:tims/routes/timer_list_screen.dart';
import '../constants.dart';
import '../utils.dart';
import 'timer_screen.dart';

class MainRoute extends StatelessWidget {
 const MainRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainVM viewmodel = Get.find<MainVM>();
		TimerScreen timerScreen = TimerScreen(key: const PageStorageKey('Timer Screen'));
		viewmodel.timerMediator = timerScreen;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Study Timer",
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(LineIcons.gripLines),
            );
          },
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LineIcons.cog))
        ],
      ),
      drawer: const _MainRouteDrawer(),
      body: PageStorage(
          bucket: PageStorageBucket(),
          child: PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child);
            },
            child: Obx(
              () => IndexedStack(
							index: viewmodel.navigationIndex.value,
							children: [
								timerScreen,
								const StopwatchScreen(key: PageStorageKey('Stopwatch Screen')),
								const TimerListScreen(key: PageStorageKey('Timer List Screen')),
								const HistoryScreen(key: PageStorageKey('History Screen')),
							],
						),
            ) 
          ),
        ),
    );
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                  const Icon(LineIcons.userCircleAlt, size: 100),
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
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: const NavigationDrawerTile(
                        icon: LineIcons.clock, tileLabel: 'Timer', index: 0),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: const NavigationDrawerTile(
                        icon: LineIcons.flag, tileLabel: 'Stopwatch', index: 1),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: const NavigationDrawerTile(
                        icon: LineIcons.list,
                        tileLabel: 'Timer List',
                        index: 2),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: const NavigationDrawerTile(
                        icon: LineIcons.history,
                        tileLabel: 'History',
                        index: 3),
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
  const NavigationDrawerTile(
      {Key? key,
      required this.icon,
      required this.tileLabel,
      required this.index})
      : super(key: key);
  final IconData icon;
  final String tileLabel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index == Get.find<MainVM>().navigationIndex.value
          ? drawerTileDarkTheme
          : Colors.transparent,
      borderRadius: BorderRadius.circular(55),
      child: InkWell(
        onTap: () {
          Get.find<MainVM>().navigationIndex.value = index;
          navigator!.pop();
        },
        borderRadius: BorderRadius.circular(55),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
      ),
    );
  }
}
