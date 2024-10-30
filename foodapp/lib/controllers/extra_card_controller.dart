import 'package:get/get.dart';

class ExtraCardController extends GetxController {
  var selectedIndex = 0.obs;

  void selectPaymentMethod(int index) {
    selectedIndex.value = index;
  }
}
