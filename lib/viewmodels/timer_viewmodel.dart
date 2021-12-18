import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerVM extends GetxController {

	// Time Status
  RxBool isTimerActive = false.obs;
  void toggleTimer() {
    isTimerActive.value = !isTimerActive.value;
  }
  void turnOffTimer() {
    isTimerActive.value = false;
  }

	// Time Animation Controller
  AnimationController? _timeController;
  void setTimeController(AnimationController controller) =>
      _timeController = controller;
  AnimationController getTimeController() => _timeController!;

	// Current Timer Duration
  Duration? _currentTimerDuration = const Duration(seconds: 10);
	void setCurrentTimerDuration(Duration duration) {
		_currentTimerDuration = duration;
	}
  get currentTimerDuration => _currentTimerDuration;
  Tween<Duration> getTimerTween() {
    return Tween<Duration>(begin: _currentTimerDuration, end: Duration.zero);
  }

	// Formatted Timer String
  String formattedTimerString(Animation animation) =>
      "${(animation.value as Duration).inMinutes.toString().padLeft(2, '0')}:${((animation.value as Duration).inSeconds % 60).toString().padLeft(2, '0')}";
}
