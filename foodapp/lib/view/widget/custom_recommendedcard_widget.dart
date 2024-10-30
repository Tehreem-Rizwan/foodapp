import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:get/get.dart';

class RecommendedCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String rating;
  final String distance;
  final String price;

  const RecommendedCardWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.distance,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
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
                  Get.to(() => ());
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CommonImageView(
                    imagePath: imagePath,
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
                  text: title,
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
                      text: rating,
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
                      text: distance,
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackyColor,
                      fontFamily: AppFonts.Inter,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                CustomText(
                  text: price,
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
