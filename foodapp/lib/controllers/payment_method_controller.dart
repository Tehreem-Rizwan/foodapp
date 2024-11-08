import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  var selectedMethod = ''.obs; // Observable variable to track selected method

  void selectMethod(String method) {
    selectedMethod.value = method;
  }
}
