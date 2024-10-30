import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/cart/cart_screen.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
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
          text: AppLocalizations.of(context)!.mycart,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: only(context, right: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kWhite12Color),
              ),
              child: IconButton(
                icon: const Image(image: AssetImage(Assets.imagesThreedots)),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonImageView(
              imagePath: Assets.imagesSearchIllustration,
              height: 207,
              width: 278,
              fit: BoxFit.contain,
            ),
            SizedBox(height: h(context, 36)),
            Column(
              children: [
                CustomText(
                    text: AppLocalizations.of(context)!.ouchHungry,
                    size: 24,
                    weight: FontWeight.w700,
                    color: kBlackyColor),
                SizedBox(height: h(context, 12)),
                CustomText(
                  text: AppLocalizations.of(context)!
                      .seemslikeyouhavenotorderedanyfoodyet,
                  size: 16,
                  weight: FontWeight.w400,
                  color: kgreyblackColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: h(context, 34)),
            Center(
              child: CustomButton(
                height: 52,
                width: w(context, 327),
                buttonText: AppLocalizations.of(context)!.findfood,
                textSize: 14,
                backgroundColor: kTertiaryColor,
                onTap: () {
                  Get.to(() => CartScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
