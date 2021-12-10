import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StopwatchVM extends GetxController {
  RxBool isTimerActive = false.obs;
  void toggleTimer() {
    isTimerActive.value = !isTimerActive.value;
  }

  AnimationController? _timeController;
  void setTimeController(AnimationController controller) =>
      _timeController = controller;
  AnimationController getTimeController() => _timeController!;
}