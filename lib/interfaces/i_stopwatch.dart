import 'package:flutter/material.dart';
import 'package:tims/interfaces/i_clock.dart';

abstract class IStopwatch extends IClock {
	/// Get clock animation controller
	AnimationController getTimeController();
	/// Set clock animation controller
	AnimationController setTimeController(AnimationController timeController);
	/// Get clock animation controller
	AnimationController getCircleController();
	/// Set clock animation controller
	AnimationController setCircleController(AnimationController circleController);
}
