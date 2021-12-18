import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/routes/timer_screen.dart';

class MainVM extends GetxController {
  RxInt navigationIndex = 0.obs;
  void navigate(int i) {
    navigationIndex.value = i;
  }
}
