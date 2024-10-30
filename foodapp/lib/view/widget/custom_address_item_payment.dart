import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class AddressItem extends StatelessWidget {
  final String label;
  final String value;

  AddressItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            size: 14,
            weight: FontWeight.w400,
            color: kgreyblackColor,
          ),
          CustomText(
            text: value,
            size: 14,
            weight: FontWeight.w600,
            color: kBlackyColor,
          ),
        ],
      ),
    );
  }
}
