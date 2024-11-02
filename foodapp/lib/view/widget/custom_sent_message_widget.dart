import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class SentMessageWidget extends StatelessWidget {
  final String text;
  final String time;
  final bool isRead;

  const SentMessageWidget({
    Key? key,
    required this.text,
    required this.time,
    required this.isRead,
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
                  text: text,
                  size: 12,
                  weight: FontWeight.w500,
                  color: kSecondaryColor,
                ),
              ),
              Row(
                children: [
                  CustomText(
                    text: time,
                    size: 10,
                    weight: FontWeight.w500,
                    color: kgreyblackColor,
                  ),
                  if (isRead)
                    Image(
                      image: AssetImage(Assets.imagesDoubleCheck),
                      color: kTertiaryColor,
                      height: 20,
                    )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
