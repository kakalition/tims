import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/interfaces/i_clock_mediator.dart';
import 'package:tims/notification_service.dart';

class MainVM extends GetxController {
  RxInt navigationIndex = 0.obs;
  void navigate(int i) {
    navigationIndex.value = i;
  }

	double _scrollableHeight = 0;
  double _circleTimerSize = 0;
	double _circleClockSize = 0;
	double _playButtonSize = 0;
	double _restartButtonSize = 0;
	double _playIconSize = 0;
	double _restartIconSize = 0;
	double _revealLengthFactor = 0;
	double _digitSpacing = 0; 
	double _digitPieceSize = 0;

	double get scrollableHeight => _scrollableHeight;
	double get circleTimerSize => _circleTimerSize;
	double get circleClockSize => _circleClockSize;
	double get playButtonSize => _playButtonSize;
	double get restartButtonSize => _restartButtonSize;
	double get playIconSize => _playIconSize;
	double get restartIconSize => _restartIconSize;
	double get revealLengthFactor => _revealLengthFactor;
	double get digitSpacing => _digitSpacing;
	double get digitPieceSize => _digitPieceSize;

	void initWidgetSize(BuildContext context) {
		_scrollableHeight = MediaQuery.of(context).size.height * 0.88;
		_circleTimerSize = MediaQuery.of(context).size.width * 0.62;
		_circleClockSize = MediaQuery.of(context).size.height * 0.26;
		_playButtonSize = _circleTimerSize / 1.618 / 1.8;
		_restartButtonSize = _playButtonSize / 1.618;
		_playIconSize = _playButtonSize * 0.5;
		_restartIconSize = _restartButtonSize * 0.4;
		_revealLengthFactor = MediaQuery.of(context).size.height * 0.16; 
		_digitSpacing = MediaQuery.of(context).size.width * 0.03;
    _digitPieceSize = MediaQuery.of(context).size.width * 0.15;
	}

	final NotificationService _notificationService = NotificationService();
	NotificationService get notificationService => _notificationService;

	IClockMediator? _timerMediator;
	IClockMediator get timerMediator => _timerMediator!;
	set timerMediator(IClockMediator timerMediator) => _timerMediator = timerMediator;
}
