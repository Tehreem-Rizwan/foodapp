import 'package:get/get.dart';

class BurgerController extends GetxController {
  var isFavorite = false.obs;
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}
