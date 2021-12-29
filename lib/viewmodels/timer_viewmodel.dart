import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/interfaces/i_show_notification.dart';
import 'package:tims/interfaces/i_timer.dart';

import '../notification_service.dart';

class TimerVM extends GetxController implements ITimer, IShowNotification{

	final RxBool _clockActiveStatus = false.obs;

  @override
  bool getClockActiveStatus() {
		return _clockActiveStatus.value;
  }

	AnimationController? _clockController;

  @override
  AnimationController getClockController() {
		return _clockController!;
  }

  @override
  AnimationController setClockController(AnimationController clockController) {
		_clockController = clockController;
		return clockController;
  }

  @override
  void playClock() {
		_clockActiveStatus.value = true;
		_clockController!.forward();
  }

  @override
  Future<void> restartClock() async {
		_clockActiveStatus.value = false;
		await _clockController!.reverse();
		_clockController!.reset();
  }

  @override
  void stopClock() {
		_clockActiveStatus.value = false;
		_clockController!.stop(canceled: false);
  }

	@override
	Future<void> showNotification(NotificationService notificationService, String title, String body) async {
		await notificationService.flutterLocalNotificationsPlugin.show(0, title, body, notificationService.platformChannelSpecifics, payload: 'Payload');
	}

	// TODO: Implement Correctly Later!
  void setTimerDuration() {
		_clockController?.duration = const Duration(seconds: 5);
  }

	// Current Timer Duration
  Duration? _currentTimerDuration = const Duration(seconds: 5);
	void setCurrentTimerDuration(Duration duration) {
		_currentTimerDuration = duration;
	}
  get currentTimerDuration => _currentTimerDuration;
  Tween<Duration> getTimerTween() {
    return Tween<Duration>(begin: _currentTimerDuration, end: Duration.zero);
  }

}
