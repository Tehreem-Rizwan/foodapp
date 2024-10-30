import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationRowWidget extends StatelessWidget {
  const InformationRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: all(context, 8),
      decoration: BoxDecoration(
        color: klightorange,
        borderRadius: BorderRadius.circular(h(context, 8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoItemWidget(
            iconPath: Assets.imagesDollarsign,
            label: AppLocalizations.of(context)!.freedelivery,
          ),
          const InfoItemWidget(
            iconPath: Assets.imagesTimer,
            label: "20 - 30",
          ),
          const InfoItemWidget(
            iconPath: Assets.imagesFilledorangestar,
            label: "4.5",
          ),
        ],
      ),
    );
  }
}

class InfoItemWidget extends StatelessWidget {
  final String iconPath;
  final String label;

  const InfoItemWidget({
    Key? key,
    required this.iconPath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, width: 10, height: 30),
        SizedBox(width: w(context, 8)),
        CustomText(
          fontFamily: AppFonts.Inter,
          text: label,
          size: 14,
          weight: FontWeight.w400,
          color: kgreyblackColor,
        ),
      ],
    );
  }
}
