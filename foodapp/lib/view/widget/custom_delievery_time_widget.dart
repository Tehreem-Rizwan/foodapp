import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class DeliveryTimeWidget extends StatelessWidget {
  final String deliveryText;
  final String estimatedTime;
  final Color primaryColor;
  final Color secondaryColor;

  const DeliveryTimeWidget({
    Key? key,
    required this.deliveryText,
    required this.estimatedTime,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: deliveryText,
                size: 14,
                weight: FontWeight.w600,
                color: primaryColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomText(
                text: estimatedTime,
                size: 12,
                weight: FontWeight.w400,
                color: secondaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
