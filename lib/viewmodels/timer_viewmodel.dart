import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerVM extends GetxController {
  RxBool isTimerActive = false.obs;
  void toggleTimer() {
    isTimerActive.value = !isTimerActive.value;
  }

  void turnOffTimer() {
    isTimerActive.value = false;
  }

  AnimationController? _timeController;
  void setTimeController(AnimationController controller) =>
      _timeController = controller;
  AnimationController getTimeController() => _timeController!;

  Duration? _currentTimerDuration = Duration(minutes: 1, seconds: 30);
  get currentTimerDuration => _currentTimerDuration;
  Tween<Duration> getTimerTween() {
    return Tween<Duration>(begin: _currentTimerDuration, end: Duration.zero);
  }

  String formattedTimerString(Animation animation) =>
      "${(animation.value as Duration).inMinutes.toString().padLeft(2, '0')}:${((animation.value as Duration).inSeconds % 60).toString().padLeft(2, '0')}";
}
