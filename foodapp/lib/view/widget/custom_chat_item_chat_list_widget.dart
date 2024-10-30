import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/custom_text_widget.dart';

class ChatItemWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String message;
  final String time;
  final bool showBadge;
  final bool isRead;

  const ChatItemWidget({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.message,
    required this.time,
    this.showBadge = false,
    this.isRead = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: h(context, 20),
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    fontFamily: AppFonts.Inter,
                    text: name,
                    size: 14,
                    weight: FontWeight.w600,
                    color: kBlackyColor,
                  ),
                  CustomText(
                    fontFamily: AppFonts.Inter,
                    text: message,
                    size: 12,
                    weight: FontWeight.w500,
                    color: kgreyblackColor,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CustomText(
                  fontFamily: AppFonts.Inter,
                  text: time,
                  size: 12,
                  weight: FontWeight.w500,
                  color: kgreyblackColor,
                ),
                if (showBadge)
                  Container(
                    margin: only(context, top: 8),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTertiaryColor,
                    ),
                    child: CustomText(
                      fontFamily: AppFonts.Inter,
                      text: "3", // You can replace this with dynamic count
                      size: 10,
                      weight: FontWeight.w500,
                      color: kSecondaryColor,
                    ),
                  ),
                if (isRead)
                  Image.asset(
                    Assets.imagesDoubleCheck,
                    width: 20,
                    height: 20,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
