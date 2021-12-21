import 'package:get/get.dart';
import 'package:tims/routes/timer_list_screen.dart';

class TimerListVM extends GetxController {
  final Rx<TimerTypeValue?> _currentRadioValue = TimerTypeValue.normal.obs;
	get currentRadioValue => _currentRadioValue;
	void setRadioValue(TimerTypeValue? value) {
		_currentRadioValue.value = value;
	}
	void toAddTimer() {
		if(_currentRadioValue.value == TimerTypeValue.normal) {
			navigator!.pushNamed('/addnormaltimer');
		} else {
			navigator!.pushNamed('/addintervaltimer');
		}
	}
}
