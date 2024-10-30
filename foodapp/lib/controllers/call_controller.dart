import 'dart:async';
import 'package:get/get.dart';

class CallController extends GetxController {
  var seconds = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      seconds.value++;
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
