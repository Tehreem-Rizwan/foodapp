import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class NotificationItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  NotificationItem({
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8), // or symmetric(context, vertical: 8) if custom
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kSecondaryColor,
              border: Border.all(color: kWhite12Color),
            ),
            child: Center(
              child: Image.asset(iconPath, width: 24, height: 24),
            ),
          ),
          SizedBox(
              width: 16), // or use w(context, 16) if custom method is required
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
                SizedBox(height: 4), // or h(context, 4) if custom
                CustomText(
                  text: subtitle,
                  size: 14,
                  weight: FontWeight.w400,
                  color: kgreyblackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
