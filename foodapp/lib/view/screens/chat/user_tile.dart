import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/custom_text_widget.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String? lastMessage; // Last message text
  final String? time; // Timestamp of last message
  final bool showBadge; // Visibility of unread messages count
  final bool isRead; // Indicates if the last message is read
  final void Function()? onTap;

  const UserTile({
    Key? key,
    required this.text,
    this.lastMessage,
    this.time,
    this.showBadge = false,
    this.isRead = false,
    this.onTap,
    required int unreadCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          fontFamily: AppFonts.Inter,
                          text: lastMessage ?? '',
                          size: 12,
                          weight: FontWeight.w500,
                          color: kGreyColor,
                        ),
                        CustomText(
                          fontFamily: AppFonts.Inter,
                          text: time ?? '',
                          size: 12,
                          weight: FontWeight.w500,
                          color: kgreyblackColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showBadge) ...[
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kTertiaryColor,
                  ),
                  child: CustomText(
                    fontFamily: AppFonts.Inter,
                    text: "3", // Replace with dynamic count
                    size: 10,
                    weight: FontWeight.w500,
                    color: kSecondaryColor,
                  ),
                ),
              ],
              if (isRead)
                Image.asset(
                  Assets.imagesDoubleCheck,
                  width: 20,
                  height: 20,
                  color: kTertiaryColor, // Change color if read
                )
              else
                Image.asset(
                  Assets.imagesDoubleCheck,
                  width: 20,
                  height: 20,
                  color: kGreyColor, // Default color if not read
                ),
            ],
          ),
        ),
      ),
    );
  }
}
