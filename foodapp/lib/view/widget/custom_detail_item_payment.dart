import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class DetailItem extends StatelessWidget {
  final String name;
  final String price;
  final bool highlight;

  const DetailItem({
    Key? key,
    required this.name,
    required this.price,
    this.highlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: name,
            size: 14,
            weight: FontWeight.w400,
            color: kgreyblackColor,
          ),
          CustomText(
            text: price,
            size: 14,
            weight: FontWeight.w600,
            color: highlight ? kTertiaryColor : kBlackyColor,
          ),
        ],
      ),
    );
  }
}
