import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecentOrdersList extends StatelessWidget {
  const RecentOrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderItem(
          imagePath: Assets.imagesAboutthismenu,
          title: AppLocalizations.of(context)!.ordinaryburger,
          restaurant: AppLocalizations.of(context)!.burgerresturant,
          rating: '4.9',
          distance: '190m',
        ),
        OrderItem(
          imagePath: Assets.imagesAboutthismenu,
          title: AppLocalizations.of(context)!.ordinaryburger,
          restaurant: AppLocalizations.of(context)!.burgerresturant,
          rating: '4.9',
          distance: '190m',
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String restaurant;
  final String rating;
  final String distance;

  const OrderItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.restaurant,
    required this.rating,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(imagePath, width: 70, height: 65),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  size: 16,
                  weight: FontWeight.w600,
                  color: kBlackyColor,
                ),
                CustomText(
                  text: restaurant,
                  size: 12,
                  weight: FontWeight.w400,
                  color: kgreyblackColor,
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: kTertiaryColor, size: 16),
                    SizedBox(width: 4),
                    CustomText(
                      text: rating,
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackyColor,
                    ),
                    SizedBox(width: 12),
                    Image(
                      image: AssetImage(Assets.imagesLocation),
                      color: kTertiaryColor,
                      height: 14,
                    ),
                    SizedBox(width: 4),
                    CustomText(
                      text: distance,
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
