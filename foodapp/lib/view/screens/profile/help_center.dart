import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:foodapp/view/widget/custom_help_card_help_center-widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0,
        leading: Padding(
          padding: only(context, left: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kWhite12Color),
            ),
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
                size: 16,
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
        title: CustomText(
          text: AppLocalizations.of(context)!.helpCenter,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: only(context, left: 24, right: 24),
        child: ListView(
          children: [
            SizedBox(height: h(context, 16)),
            CustomText(
              text: AppLocalizations.of(context)!.hihowwecanhelpyou,
              size: 16,
              weight: FontWeight.w600,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 16)),
            buildSearchBar(context),
            SizedBox(height: h(context, 24)),
            HelpCard(
              iconPath: Assets.imagesGeneral,
              title: AppLocalizations.of(context)!.general,
              description:
                  AppLocalizations.of(context)!.basicquestionaboutRestate,
            ),
            HelpCard(
              iconPath: Assets.imagesSeller,
              title: AppLocalizations.of(context)!.sellers,
              description: AppLocalizations.of(context)!
                  .allyouneedtoknowaboutsellingyourhometoRestate,
            ),
            HelpCard(
              iconPath: Assets.imagesBuyer,
              title: AppLocalizations.of(context)!.buyers,
              description: AppLocalizations.of(context)!
                  .everythingyouneedtoknowaboutbuyingwithRestate,
            ),
            HelpCard(
              iconPath: Assets.imagesAgent,
              title: AppLocalizations.of(context)!.agents,
              description: AppLocalizations.of(context)!
                  .howbuyingagentsandlistingagentscanworkwithRestate,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      padding: symmetric(context, vertical: 7, horizontal: 16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(h(context, 8)),
        border: Border.all(color: kWhite12Color),
      ),
      child: Row(
        children: [
          Image.asset(
            Assets.imagesSearch,
            width: 20,
            height: 20,
            color: kgreyblackColor,
          ),
          SizedBox(width: w(context, 12)),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: kgreyblackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
