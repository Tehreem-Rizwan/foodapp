import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/screens/chat/models/message.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final Message message;

  const ReceivedMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: message.message,
                size: 14,
                weight: FontWeight.w600,
                color: kBlackyColor,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: kGreyLightColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
