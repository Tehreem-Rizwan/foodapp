import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class PaymentMethodCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String number;
  final String brandIconPath;
  final bool isSelected;

  const PaymentMethodCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.number,
    required this.brandIconPath,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16), // Use a fixed value or helper method
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(h(context, 16)),
        border: Border.all(color: isSelected ? kTertiaryColor : kWhite12Color),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 24, height: 24),
          SizedBox(width: w(context, 16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  size: 14,
                  weight: FontWeight.w600,
                  color: kBlackyColor,
                ),
                SizedBox(height: h(context, 8)),
                CustomText(
                  text: number,
                  size: 12,
                  weight: FontWeight.w400,
                  color: kgreyblackColor,
                ),
              ],
            ),
          ),
          Image.asset(brandIconPath, width: 32, height: 32),
        ],
      ),
    );
  }
}
