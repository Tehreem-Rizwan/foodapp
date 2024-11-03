import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: all(context, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: kTertiaryColor),
      child: CustomText(
        text: message,
        size: 12,
        color: kSecondaryColor,
      ),
    );
  }
}
