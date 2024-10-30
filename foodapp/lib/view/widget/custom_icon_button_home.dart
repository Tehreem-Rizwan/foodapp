import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';

class IconButtonWidget extends StatelessWidget {
  final String assetPath;

  IconButtonWidget({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: kTransparentColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kWhite12Color),
      ),
      child: Center(
        child: Image.asset(assetPath, width: 24, height: 24),
      ),
    );
  }
}
