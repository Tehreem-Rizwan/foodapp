import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/chat/models/message.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class SentMessageWidget extends StatelessWidget {
  final Message message;
  const SentMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: all(context, 8),
                decoration: BoxDecoration(
                  color: kTertiaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: message.message,
                  size: 12,
                  weight: FontWeight.w500,
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
