import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedLocation = "New York City".obs;
  var selectedCategory = "Burger".obs;
  var selectedNavBarIndex = 0.obs;

  final List<String> countries = [
    "New York City",
    "Los Angeles",
    "Chicago",
    "San Francisco"
  ];

  void changeNavBarIndex(int index) {
    selectedNavBarIndex.value = index;
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}
