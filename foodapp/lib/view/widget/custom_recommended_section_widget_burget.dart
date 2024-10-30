import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_recommendedcard_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecommendedSectionWidget extends StatelessWidget {
  const RecommendedSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              fontFamily: AppFonts.Inter,
              text: AppLocalizations.of(context)!.recommendedforyou,
              size: 16,
              weight: FontWeight.w600,
              color: kBlackyColor,
            ),
            CustomText(
              fontFamily: AppFonts.Inter,
              text: AppLocalizations.of(context)!.seeall,
              size: 14,
              weight: FontWeight.w500,
              color: kTertiaryColor,
            ),
          ],
        ),
        SizedBox(height: h(context, 16)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              RecommendedCardWidget(
                imagePath: Assets.imagesRecommendedforu1,
                title: AppLocalizations.of(context)!.ordinaryburger,
                rating: "4.9",
                distance: "190m",
                price: "\$17,230",
              ),
              SizedBox(width: w(context, 20)),
              RecommendedCardWidget(
                imagePath: Assets.imagesBurgerwithfries,
                title: AppLocalizations.of(context)!.ordinaryburger,
                rating: "4.9",
                distance: "190m",
                price: "\$17,230",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
