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

	AnimationCenter() {
		_playPauseButtonAnimation = Tween<double>(begin: 1, end: 1.05)
				.animate(_playPauseButtonController!);
		_playPauseIconAnimation = Tween<double>(begin: 0, end: 1)
        .animate(_playPauseIconController!)
        .drive(CurveTween(curve: Curves.easeOut));
		_revealButtonAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0, mainViewmodel.revealLengthFactor))
        .animate(_revealButtonController!.drive(CurveTween(curve: Curves.easeOut)));
		_timerTimeAnimation = Tween<Duration>(begin: timerViewmodel.currentTimerDuration, end: Duration.zero)
				.animate(_timerTimeController!);
		_stopwatchTimeAnimation = Tween<Duration>(begin: Duration.zero, end: const Duration(days: 30))
				.animate(_stopwatchTimeController!);
    _timerCircleAnimation = Tween<double>(begin: 1, end: 0)
				.animate(_timerCircleController!);
		_stopwatchCircleAnimation = Tween<double>(begin: 0, end: 2)
				.animate(_stopwatchCircleController!);
	}

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
	void setAnimationController(TimsAnimation anim, AnimationController controller) {
		switch(anim) {
		  case TimsAnimation.playPauseButton:
				_playPauseButtonController = controller;
				break;
		  case TimsAnimation.playPauseIcon:
		    _playPauseIconController = controller;
				break;
		  case TimsAnimation.revealButton:
		    _revealButtonController = controller;
				break;
		  case TimsAnimation.timerTime:
		    _timerTimeController = controller;
				break;
		  case TimsAnimation.stopwatchTime:
				_stopwatchTimeController = controller;
				break;
		  case TimsAnimation.timerCircle:
		    _timerCircleController = controller;
				break;
		  case TimsAnimation.stopwatchCircle:
		    _stopwatchCircleController = controller;
				break;
		}
	}

	/// Returns animation controller of corresponding enum.
	Animation? getAnimationController(TimsAnimation anim) {
		switch(anim) {
		  case TimsAnimation.playPauseButton:
				return _playPauseButtonController;
		  case TimsAnimation.playPauseIcon:
		    return _playPauseIconController;
		  case TimsAnimation.revealButton:
		    return _revealButtonController;
		  case TimsAnimation.timerTime:
		    return _timerTimeController;
		  case TimsAnimation.stopwatchTime:
				return _stopwatchTimeController;
		  case TimsAnimation.timerCircle:
		    return _timerCircleController;
		  case TimsAnimation.stopwatchCircle:
		    return _stopwatchCircleController;
		}
	}
	/// Set animation to corresponding enum.
	void setAnimation(TimsAnimation anim, Animation animation) {
		switch(anim) {
		  case TimsAnimation.playPauseButton:
				_playPauseButtonAnimation = animation as Animation<double>;
				break;
		  case TimsAnimation.playPauseIcon:
		    _playPauseIconAnimation = animation as Animation<double>;
				break;
		  case TimsAnimation.revealButton:
		    _revealButtonAnimation = animation as Animation<Offset>;
				break;
		  case TimsAnimation.timerTime:
		    _timerTimeAnimation = animation as Animation<Duration>;
				break;
		  case TimsAnimation.stopwatchTime:
				_stopwatchTimeAnimation = animation as Animation<Duration>;
				break;
		  case TimsAnimation.timerCircle:
		    _timerCircleAnimation = animation as Animation<double>;
				break;
		  case TimsAnimation.stopwatchCircle:
		    _stopwatchCircleAnimation = animation as Animation<double>;
				break;
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
}
