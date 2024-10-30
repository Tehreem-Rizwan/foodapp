import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final String avatar;
  final String text;
  final String time;

  const ReceivedMessageWidget({
    Key? key,
    required this.avatar,
    required this.text,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(avatar),
          ),
          SizedBox(width: w(context, 16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.stevanoClirover,
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
                child: CustomText(
                  text: text,
                  size: 12,
                  weight: FontWeight.w500,
                  color: kBlackyColor,
                ),
              ),
              CustomText(
                text: time,
                size: 10,
                weight: FontWeight.w500,
                color: kgreyblackColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
