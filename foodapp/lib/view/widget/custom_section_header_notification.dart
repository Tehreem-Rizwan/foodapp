import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: CustomText(
        text: title,
        size: 14,
        weight: FontWeight.w600,
        color: kgreyblackColor,
      ),
    );
  }
}
