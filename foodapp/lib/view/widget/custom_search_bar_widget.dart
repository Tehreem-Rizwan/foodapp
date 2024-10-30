import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';

class CustomSearchBar extends StatelessWidget {
  final double width;
  final double height;

  final String hintText;
  final TextEditingController controller;

  const CustomSearchBar({
    Key? key,
    this.width = double.infinity,
    required this.height,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, width),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        border: Border.all(color: Color(0xFFD6D6D6), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: kPrimaryColor),
          SizedBox(width: w(context, 8)),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: kBlackyColor,
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
            color: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
