import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';

class CustomFoodSearchBar extends StatelessWidget {
  final double width;
  final double height;

  final String hintText;
  final TextEditingController Foodcontroller;

  const CustomFoodSearchBar({
    Key? key,
    this.width = double.infinity,
    required this.height,
    required this.hintText,
    required this.Foodcontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, width),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        border: Border.all(color: Color(0xFFD6D6D6), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage(Assets.imagesSearch),
            color: kgreyblackColor,
          ),
          SizedBox(width: w(context, 8)),
          Expanded(
            child: TextFormField(
              controller: Foodcontroller, // Use the controller to capture input
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: kgreyblackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextStyle(
                color: kBlackyColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Image(
            image: AssetImage(Assets.imagesTune),
            color: kgreyblackColor,
          ),
        ],
      ),
    );
  }
}
