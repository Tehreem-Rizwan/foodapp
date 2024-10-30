import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class RecordIndicator extends StatelessWidget {
  final String formattedTime;

  const RecordIndicator({
    Key? key,
    required this.formattedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: w(context, 12), vertical: h(context, 6)),
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.imagesRecord),
          SizedBox(width: w(context, 4)),
          CustomText(
            text: formattedTime, // Use the passed formatted time
            size: 14,
            weight: FontWeight.w400,
            color: kBlackyColor,
          ),
        ],
      ),
    );
  }
}
