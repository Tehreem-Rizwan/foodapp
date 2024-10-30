import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/launch/auth/signin_screen.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Adjust size according to content
      children: [
        SizedBox(height: h(context, 32)),
        CommonImageView(
          imagePath: Assets.imagesIllustrationSuccess,
          fit: BoxFit.contain,
          height: 168,
          width: 202.62,
        ),
        SizedBox(height: h(context, 32)),
        CustomText(
          text: AppLocalizations.of(context)!.passwordchanged,
          size: 24,
          weight: FontWeight.bold,
          fontFamily: AppFonts.Inter,
          color: kBlackyColor,
        ),
        SizedBox(height: h(context, 14)),
        CustomText(
          text: AppLocalizations.of(context)!
              .passwordchangedsuccessfullyyoucanloginagainwithanewpassword,
          size: 14,
          weight: FontWeight.w500,
          color: kgreyblackColor,
          fontFamily: AppFonts.Inter,
        ),
        SizedBox(height: h(context, 36)),
        CustomButton(
          height: 52,
          width: w(context, 327),
          buttonText: AppLocalizations.of(context)!.verifyaccount,
          textSize: 14,
          backgroundColor: kTertiaryColor,
          onTap: () {
            Get.to(() => SigninScreen(
                  userEmail: 'tehreemrizwan30@gmail.com',
                ));
          },
        ),
      ],
    );
  }
}
