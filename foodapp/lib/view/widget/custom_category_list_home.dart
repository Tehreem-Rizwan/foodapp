import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class CategoryList extends StatelessWidget {
  final List<Map<String, String>> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  CategoryList({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: symmetric(context, horizontal: 20),
      child: Row(
        children: categories.map((category) {
          return Row(
            children: [
              _categoryItem(context, category['name']!, category['assetPath']!),
              SizedBox(width: w(context, 30)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _categoryItem(BuildContext context, String name, String assetPath) {
    bool isSelected = selectedCategory == name;
    return GestureDetector(
      onTap: () {
        onCategorySelected(name);
      },
      child: Container(
        height: h(context, 68),
        width: w(context, 65),
        padding: all(context, 8),
        decoration: BoxDecoration(
          color: isSelected ? kTertiaryColor : kSecondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: 24,
              height: 24,
            ),
            SizedBox(height: h(context, 5)),
            Flexible(
              child: CustomText(
                text: name,
                size: 12,
                weight: FontWeight.w500,
                color: isSelected ? kSecondaryColor : kgreyblackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
