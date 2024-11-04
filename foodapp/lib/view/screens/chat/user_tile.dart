import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/custom_text_widget.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String? lastMessage; // Add last message text
  final String? time; // Add time text
  final bool showBadge; // Add badge visibility
  final bool isRead; // Add read status for messages
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    this.lastMessage,
    this.time,
    this.showBadge = false,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
                radius: h(context, 16),
                backgroundColor: klightbluecolor,
                child: Icon(
                  Icons.person,
                  size: 24,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      fontFamily: AppFonts.Inter,
                      text: text,
                      size: 14,
                      weight: FontWeight.w600,
                      color: kBlackyColor,
                    ),
                    if (lastMessage != null)
                      CustomText(
                        fontFamily: AppFonts.Inter,
                        text: lastMessage!,
                        size: 12,
                        weight: FontWeight.w500,
                        color: kgreyblackColor,
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (time != null)
                    CustomText(
                      fontFamily: AppFonts.Inter,
                      text: time!,
                      size: 12,
                      weight: FontWeight.w500,
                      color: kgreyblackColor,
                    ),
                  if (showBadge)
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kTertiaryColor,
                      ),
                      child: CustomText(
                        fontFamily: AppFonts.Inter,
                        text:
                            "3", // Replace with dynamic message count if needed
                        size: 10,
                        weight: FontWeight.w500,
                        color: kSecondaryColor,
                      ),
                    ),
                  if (isRead)
                    Icon(
                      Icons.check,
                      size: 20,
                      color:
                          kPrimaryColor, // You can use any check icon or image
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
