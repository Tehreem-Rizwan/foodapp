import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodapp/constants/app_images.dart';

class SearchFoodController extends GetxController {
  var selectedCategory = "Burger".obs;
  final TextEditingController searchFoodController = TextEditingController();

  final List<Map<String, String>> categories = [
    {"name": "Burger", "assetPath": Assets.imagesBurgercategory},
    {"name": "Taco", "assetPath": Assets.imagesTacoscategory},
    {"name": "Drink", "assetPath": Assets.imagesDrinkcategory},
    {"name": "Pizza", "assetPath": Assets.imagesPizzacategory},
  ];

  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onClose() {
    searchFoodController.dispose();
    super.onClose();
  }
}
