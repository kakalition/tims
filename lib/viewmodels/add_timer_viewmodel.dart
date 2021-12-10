import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTimerVM extends GetxController {
  final RxInt _timePointer = 0.obs;
  final RxList<int> _timeDigit = RxList<int>([0, 0, 0, 0]);

  get timePointer => _timePointer;
  get timeDigit => _timeDigit;

  void clickTimePiece() {
    if (_timePointer.value == 0) {
      _timePointer.value++;
    } else if (_timePointer.value == 1) {
      _timePointer.value++;
    } else if (_timePointer.value == 2) {
      _timePointer.value++;
    } else if (_timePointer.value == 3) {}
  }

  void deleteTimePiece() {
    if (_timePointer.value == 0) {
    } else if (_timePointer.value == 1) {
      _timePointer.value--;
    } else if (_timePointer.value == 2) {
      _timePointer.value--;
    } else if (_timePointer.value == 3) {
      _timePointer.value--;
    }
  }

  void changeTimeDigit(int value) {
    if (_timePointer.value == 0) {
      _timeDigit[0] = value;
    } else if (_timePointer.value == 1) {
      _timeDigit[1] = value;
    } else if (_timePointer.value == 2) {
      _timeDigit[2] = value;
    } else if (_timePointer.value == 3) {
      _timeDigit[3] = value;
    }
  }

  void Function() clickDigit(int value) => () {
        _timeDigit.refresh();
        changeTimeDigit(value);
        clickTimePiece();
      };

  void Function() deleteDigit() => () {
        deleteTimePiece();
        changeTimeDigit(0);
      };
}
