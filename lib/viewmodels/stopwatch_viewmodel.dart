import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/interfaces/i_stopwatch.dart';

class StopwatchVM extends GetxController implements IStopwatch{

	final RxBool _clockActiveStatus = false.obs;

  @override
  bool getClockActiveStatus() {
		return _clockActiveStatus.value;
  }

	AnimationController? _timeController;
	AnimationController? _circleController;

  @override
  AnimationController getTimeController() {
		return _timeController!;
  }

  @override
  AnimationController getCircleController() {
		return _circleController!;
  }

  @override
  AnimationController setTimeController(AnimationController timeController) {
		_timeController = timeController;
		return timeController;
  }

  @override
  AnimationController setCircleController(AnimationController circleController) {
		_circleController = circleController;
		return circleController;
  }

  @override
  void playClock() {
		_clockActiveStatus.value = true;
		_timeController!.forward();
		_circleController!.repeat();
  }

  @override
  Future<void> restartClock() async {
		_clockActiveStatus.value = false;
		await _timeController!.reverse();
		await _circleController!.reverse();
		_timeController!.reset();
		_circleController!.reset();
  }

  @override
  void stopClock() {
		_clockActiveStatus.value = false;
		_timeController!.stop(canceled: false);
		_circleController!.stop(canceled: false);
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
