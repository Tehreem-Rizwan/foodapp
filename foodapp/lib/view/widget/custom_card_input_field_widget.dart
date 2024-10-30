import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool withIcon;
  final TextEditingController? controller;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.withIcon = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            size: 16,
            weight: FontWeight.w400,
            color: kBlackyColor,
          ),
          SizedBox(height: h(context, 8)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFD6D6D6)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: placeholder,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kBlackyColor,
                    ),
                  ),
                ),
                if (withIcon)
                  Image.asset(Assets.imagesCardnumber, width: 20, height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
