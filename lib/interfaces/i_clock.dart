import 'package:flutter/material.dart';

abstract class IClock {
	/// Get clock active status from RxBool.
	bool getClockActiveStatus();
	/// Get clock animation controller
	AnimationController getClockController();
	/// Set clock animation controller
	AnimationController setClockController(AnimationController clockController);
	/// Play clock.
	void playClock();
	/// Stop clock.
	void stopClock();
	/// Restart clock.
	void restartClock();
}
