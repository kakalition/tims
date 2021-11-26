import 'package:tims/constants.dart';

import '../routes/splash_route.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: blackColorWhiteTheme),
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashRoute(),
        ),
      ],
      initialRoute: '/',
    );
  }
}
