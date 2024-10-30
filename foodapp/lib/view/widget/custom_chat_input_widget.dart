import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodapp/constants/app_styling.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                border: Border.all(color: const Color(0xFFD6D6D6)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image(
                      image: AssetImage(Assets.imagesEmoji),
                      color: kgreyblackColor),
                  SizedBox(width: w(context, 16)),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.typesomething,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kgreyblackColor,
                        ),
                      ),
                    ),
                  ),
                  Image(
                      image: AssetImage(Assets.imagesAttachment),
                      color: kgreyblackColor),
                ],
              ),
            ),
          ),
          SizedBox(width: w(context, 8)),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kTertiaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.send, color: kSecondaryColor),
          ),
        ],
      ),
    );
  }
}
