import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class LanguageItemWidget extends StatelessWidget {
  final String flag;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  LanguageItemWidget({
    required this.flag,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle the tap event
      child: Container(
        margin: only(context, bottom: h(context, 16)),
        padding: all(context, 16),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(h(context, 16)),
          border: Border.all(
              color: isSelected ? kTertiaryColor : Color(0xFFEAEAEA)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFF3F6FB),
              child: Text(flag, style: TextStyle(fontSize: f(context, 14))),
            ),
            SizedBox(width: w(context, 16)),
            Expanded(
              child: CustomText(
                text: language,
                size: 14,
                weight: FontWeight.w600,
                color: kBlackyColor,
              ),
            ),
            if (isSelected)
              Image.asset(Assets.imagesSelect, width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
