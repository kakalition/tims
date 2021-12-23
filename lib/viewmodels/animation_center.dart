import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_viewmodel.dart';
import 'timer_viewmodel.dart';

enum TimsAnimation {
	playPauseButton,
	playPauseIcon,
	revealButton,
	timerTime,
	stopwatchTime,
	timerCircle,
	stopwatchCircle,
}

class AnimationCenter extends GetxController {
	MainVM mainViewmodel = Get.find<MainVM>();
	TimerVM timerViewmodel = Get.find<TimerVM>();

  AnimationController? _playPauseButtonController;
	AnimationController? _playPauseIconController;
	AnimationController? _revealButtonController;
	AnimationController? _timerTimeController;
	AnimationController? _stopwatchTimeController;
	AnimationController? _timerCircleController;
	AnimationController? _stopwatchCircleController;

  Animation<double>? _playPauseButtonAnimation;
	Animation<double>? _playPauseIconAnimation;
	Animation<Offset>? _revealButtonAnimation;
	Animation<Duration>? _timerTimeAnimation;
	Animation<Duration>? _stopwatchTimeAnimation;
	Animation<double>? _timerCircleAnimation;
	Animation<double>? _stopwatchCircleAnimation;

	/// Set animation controller to corresponding enum.
	AnimationController setAnimationController(TimsAnimation anim, AnimationController controller) {
		switch(anim) {
		  case TimsAnimation.playPauseButton:
				_playPauseButtonController ??= controller;
				return controller;
		  case TimsAnimation.playPauseIcon:
		    _playPauseIconController ??= controller;
				return controller;
		  case TimsAnimation.revealButton:
		    _revealButtonController ??= controller;
				return controller;
		  case TimsAnimation.timerTime:
		    _timerTimeController ??= controller;
				return controller;
		  case TimsAnimation.stopwatchTime:
				_stopwatchTimeController ??= controller;
				return controller;
		  case TimsAnimation.timerCircle:
		    _timerCircleController ??= controller;
				return controller;
		  case TimsAnimation.stopwatchCircle:
		    _stopwatchCircleController ??= controller;
				return controller;
		}
	}

	/// Returns animation controller of corresponding enum.
	AnimationController getAnimationController(TimsAnimation anim) {
		switch(anim) {
		  case TimsAnimation.playPauseButton:
				return _playPauseButtonController!;
		  case TimsAnimation.playPauseIcon:
		    return _playPauseIconController!;
		  case TimsAnimation.revealButton:
		    return _revealButtonController!;
		  case TimsAnimation.timerTime:
		    return _timerTimeController!;
		  case TimsAnimation.stopwatchTime:
				return _stopwatchTimeController!;
		  case TimsAnimation.timerCircle:
		    return _timerCircleController!;
		  case TimsAnimation.stopwatchCircle:
		    return _stopwatchCircleController!;
		}
	}

	/// Returns animation of corresponding enum.
	Animation? getAnimation(TimsAnimation anim) {
		switch(anim) {
		  case TimsAnimation.playPauseButton:
				return _playPauseButtonAnimation;
		  case TimsAnimation.playPauseIcon:
		    return _playPauseIconAnimation;
		  case TimsAnimation.revealButton:
		    return _revealButtonAnimation;
		  case TimsAnimation.timerTime:
		    return _timerTimeAnimation;
		  case TimsAnimation.stopwatchTime:
				return _stopwatchTimeAnimation;
		  case TimsAnimation.timerCircle:
		    return _timerCircleAnimation;
		  case TimsAnimation.stopwatchCircle:
		    return _stopwatchCircleAnimation;
		}
	}

	AnimationController getTimeController(TimsAnimation anim) {
    return anim == TimsAnimation.timerTime ? _timerTimeController! : _stopwatchTimeController!;	
	}

	AnimationController getCircleController(TimsAnimation anim) {
    return anim == TimsAnimation.timerCircle ? _timerCircleController! : _stopwatchCircleController!;	
	}

	void initTimerDuration() {
		_timerTimeController!.duration = Get.find<TimerVM>().currentTimerDuration;
		_timerCircleController!.duration = Get.find<TimerVM>().currentTimerDuration;
	}

	void initStopwatchDuration() {
		_stopwatchCircleController!.duration = const Duration(milliseconds: 1500);
	}

	void initTimerAnimation() {
		if(_timerTimeAnimation == null) {
			_timerTimeAnimation = Tween<Duration>(begin: timerViewmodel.currentTimerDuration, end: Duration.zero)
					.animate(_timerTimeController!);
			_timerCircleAnimation = Tween<double>(begin: 1, end: 0)
					.animate(_timerCircleController!);
		}
	}

	void initStopwatchAnimation() {
		if(_stopwatchTimeAnimation == null) {
			_stopwatchTimeAnimation = Tween<Duration>(begin: Duration.zero, end: const Duration(days: 30))
					.animate(_stopwatchTimeController!);
			_stopwatchCircleAnimation = Tween<double>(begin: 0, end: 2)
					.animate(_stopwatchCircleController!);
		}
	}

	Animation<double> initPlayPauseButtonAnimation(AnimationController controller) {
		return Tween<double>(begin: 1, end: 1.05).animate(controller);
	}
	Animation<double> initPlayPauseIconAnimation(AnimationController controller) {
    return Tween<double>(begin: 0, end: 1).animate(controller)
			.drive(CurveTween(curve: Curves.easeOut));
	}
	Animation<Offset> initRevealButtonAnimation(AnimationController controller) {
    return Tween<Offset>(begin: Offset.zero, end: Offset(0, mainViewmodel.revealLengthFactor))
		  .animate(controller.drive(CurveTween(curve: Curves.easeOut)));
	}

}
