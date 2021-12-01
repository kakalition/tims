import 'package:get/get.dart';

class TimerVM extends GetxController {
  RxBool isTimerActive = false.obs;
  void toggleTimer() {
    isTimerActive.value = !isTimerActive.value;
  }
}
