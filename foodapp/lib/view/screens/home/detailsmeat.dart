import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_bottom_bar_burger_with_meet_widget.dart';
import 'package:foodapp/view/widget/custom_heart_button.dart';
import 'package:foodapp/view/widget/custom_information_row_widget_burger.dart';
import 'package:foodapp/view/widget/custom_recommended_section_widget_burget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BurgerWithMeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: h(context, 70),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kPrimaryColor,
                    size: 16,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                CustomText(
                  fontFamily: AppFonts.Inter,
                  text: AppLocalizations.of(context)!.aboutThisMenu,
                  size: 16,
                  weight: FontWeight.w600,
                  color: kSecondaryColor,
                ),
                HeartButton(),
              ],
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kTransparentColor,
            pinned: true,
            expandedHeight: h(context, 300),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(14),
                    ),
                    child: CommonImageView(
                      imagePath: Assets.imagesAboutthismenu,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: h(context, 30),
                    left: w(context, 170),
                    child: Center(child: Image.asset(Assets.imagesIndicator)),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h(context, 16)),
                  CustomText(
                    fontFamily: AppFonts.Inter,
                    text: AppLocalizations.of(context)!.burgerwithMeat,
                    size: 24,
                    weight: FontWeight.w600,
                    color: kBlackyColor,
                  ),
                  SizedBox(height: h(context, 8)),
                  CustomText(
                    fontFamily: AppFonts.Inter,
                    text: "\$ 12,230",
                    size: 18,
                    weight: FontWeight.w700,
                    color: kTertiaryColor,
                  ),
                  SizedBox(height: h(context, 16)),
                  InformationRowWidget(),
                  SizedBox(height: h(context, 16)),
                  Divider(),
                  SizedBox(height: h(context, 16)),
                  CustomText(
                    fontFamily: AppFonts.Inter,
                    text: AppLocalizations.of(context)!.description,
                    size: 16,
                    weight: FontWeight.w600,
                    color: kBlackyColor,
                  ),
                  SizedBox(height: h(context, 8)),
                  CustomText(
                    fontFamily: AppFonts.Inter,
                    text: AppLocalizations.of(context)!
                        .burgerWithMeatisatypicalfoodfromourrestaurantthatismuchindemandbymanypeoplethisisveryrecommendedforyou,
                    size: 14,
                    weight: FontWeight.w400,
                    color: kgreyblackColor,
                  ),
                  SizedBox(height: h(context, 32)),
                  RecommendedSectionWidget(),
                  RecommendedSectionWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
