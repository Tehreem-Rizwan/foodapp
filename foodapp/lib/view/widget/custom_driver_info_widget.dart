import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';

class DriverInfoWidget extends StatelessWidget {
  final String driverName;
  final String driverId;
  final String driverImage;
  final String messageIcon;
  final String callIcon;

  const DriverInfoWidget({
    Key? key,
    required this.driverName,
    required this.driverId,
    required this.driverImage,
    required this.messageIcon,
    required this.callIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: only(context, top: 24),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.9),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(h(context, 24))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DriverDetails(context),
          SizedBox(height: h(context, 16)),
        ],
      ),
    );
  }

  Widget DriverDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(h(context, 100)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        AssetImage(driverImage), // Dynamically use image path
                  ),
                  SizedBox(width: w(context, 16)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: driverName,
                          size: 14,
                          weight: FontWeight.w600,
                          color: kPrimaryColor),
                      CustomText(
                          text: 'ID $driverId',
                          size: 12,
                          weight: FontWeight.w400,
                          color: kPrimaryColor),
                    ],
                  ),
                  SizedBox(width: 30),
                  Row(
                    children: [
                      _buildIcon(messageIcon),
                      SizedBox(width: w(context, 16)),
                      _buildIcon(callIcon),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String iconPath) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kTertiaryColor, // Use your tertiary color
        shape: BoxShape.circle,
      ),
      child: CommonImageView(
        imagePath: iconPath,
        fit: BoxFit.contain,
        width: 18,
        height: 17,
      ),
    );
  }
}
