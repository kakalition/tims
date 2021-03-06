import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/constants.dart';
import 'package:tims/routes/add_normal_timer.dart';
import 'package:tims/routes/main_route.dart';

import '../routes/splash_route.dart';
import 'notification_service.dart';
import 'routes/add_interval_timer.dart';
import 'viewmodels/animation_center.dart';
import 'viewmodels/main_viewmodel.dart';
import 'viewmodels/stopwatch_viewmodel.dart';
import 'viewmodels/timer_viewmodel.dart';

Future<void> main() async{
	// Initialize NotificationService
  WidgetsFlutterBinding.ensureInitialized();
	await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		// Put viewmodel to memory permanently
		Get.put(MainVM(), permanent: true);
		Get.put(TimerVM());
		Get.put(StopwatchVM());
		Get.put(AnimationCenter(), permanent: true);

		// Main application
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: whiteColorDarkTheme, width: 2),
              ),
            ),
            scaffoldBackgroundColor: blackColorWhiteTheme,
            appBarTheme:
                const AppBarTheme().copyWith(color: blackColorWhiteTheme),
            toggleableActiveColor: blackColorWhiteTheme,
            unselectedWidgetColor: blackColorWhiteTheme.withOpacity(0.5),
            canvasColor: drawerColorDarkTheme),
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashRoute(),
          ),
          GetPage(
            name: '/main',
            page: () => const MainRoute(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 150),
          ),
          GetPage(
            name: '/addnormaltimer',
            page: () => AddNormalTimer(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 150),
          ),
          GetPage(
            name: '/addintervaltimer',
            page: () => AddIntervalTimer(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 150),
          ),
        ],
        initialRoute: '/');
  }
}
