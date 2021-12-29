import 'package:tims/interfaces/i_clock_component.dart';

abstract class IClockMediator {
	void notify(IClockComponent component, String event);
}
