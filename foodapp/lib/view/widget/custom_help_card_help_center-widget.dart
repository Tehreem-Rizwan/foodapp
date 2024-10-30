import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class HelpCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const HelpCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: only(context, bottom: h(context, 16)),
      padding: all(context, 16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 24, height: 24),
          SizedBox(width: w(context, 16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                size: 16,
                weight: FontWeight.w600,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomText(
                text: description,
                size: 14,
                weight: FontWeight.w400,
                color: kgreyblackColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
