import 'package:get/get.dart';

class MainVM extends GetxController {
  RxInt navigationIndex = 0.obs;
  void navigate(int i) {
    navigationIndex.value = i;
  }
}
