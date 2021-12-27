import 'package:flutter/material.dart';
import 'package:tims/interfaces/i_clock.dart';

abstract class ITimer extends IClock{
	/// Get clock animation controller
	AnimationController getClockController();
	/// Set clock animation controller
	AnimationController setClockController(AnimationController clockController);
}
