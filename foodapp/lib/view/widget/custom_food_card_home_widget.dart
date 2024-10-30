// food_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/view/screens/home/detailsmeat.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:get/get.dart';

class FoodCard extends StatelessWidget {
  final Map<String, dynamic> foodItem;

  FoodCard({
    required this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 163,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => BurgerWithMeat());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CommonImageView(
                    imagePath: foodItem['image'],
                    width: 137,
                    height: 106,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image(
                    image: AssetImage(Assets.imagesHearticon),
                    color: kRedColor,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: foodItem['title'],
                  size: 16,
                  weight: FontWeight.w500,
                  color: kBlackyColor,
                  fontFamily: AppFonts.Inter,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Image(
                      image: AssetImage(Assets.imagesStar),
                      height: 20,
                      width: 20,
                    ),
                    CustomText(
                      text: "4.9",
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackyColor,
                      fontFamily: AppFonts.Inter,
                    ),
                    SizedBox(width: 24),
                    Image(
                      image: AssetImage(Assets.imagesLocation),
                      height: 20,
                      width: 20,
                      color: kTertiaryColor,
                    ),
                    SizedBox(width: 4),
                    CustomText(
                      text: "190m",
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackyColor,
                      fontFamily: AppFonts.Inter,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                CustomText(
                  text: foodItem['price'],
                  size: 14,
                  fontFamily: AppFonts.Inter,
                  weight: FontWeight.bold,
                  color: kTertiaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
