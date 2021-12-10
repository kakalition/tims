import 'package:tims/constants.dart';
import 'package:tims/routes/add_normal_timer.dart';
import 'package:tims/routes/main_route.dart';

import '../routes/splash_route.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/add_timer_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: blackColorWhiteTheme,
            appBarTheme: AppBarTheme().copyWith(color: blackColorWhiteTheme),
            canvasColor: drawerColorDarkTheme),
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashRoute(),
          ),
          GetPage(
            name: '/main',
            page: () => MainRoute(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 150),
          ),
          GetPage(
            name: '/addtimer',
            page: () => const AddTimerRoute(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 150),
          ),
          GetPage(
            name: '/addnormaltimer',
            page: () => AddNormalTimer(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 150),
          ),
        ],
        initialRoute: '/');
  }
}
