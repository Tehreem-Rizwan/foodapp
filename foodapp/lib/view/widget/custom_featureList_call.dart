import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';

class FeatureList extends StatelessWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FeatureButton(
            iconPath: Assets.imagesEndcall,
            color: kSecondaryColor.withOpacity(0.25),
          ),
          SizedBox(width: w(context, 24)),
          FeatureButton(
            iconPath: Assets.imagesPhonecall,
            color: kRedColor,
            isCallEnd: true,
          ),
          SizedBox(width: w(context, 24)),
          FeatureButton(
            iconPath: Assets.imagesMicrophone,
            color: kSecondaryColor.withOpacity(0.25),
          ),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String iconPath;
  final Color color;
  final bool isCallEnd;

  const FeatureButton({
    Key? key,
    required this.iconPath,
    required this.color,
    this.isCallEnd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.all(16), // Replace `all(context, 16)` as `EdgeInsets.all`
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        iconPath,
        width: isCallEnd ? 28 : 24,
        height: isCallEnd ? 28 : 24,
      ),
    );
  }
}
