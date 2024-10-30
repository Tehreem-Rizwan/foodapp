import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/launch/auth/signin_screen.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: CommonImageView(
              imagePath: Assets.imagesOnboardingscreen3,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: symmetric(context, vertical: 28, horizontal: 30),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 45),
                    decoration: BoxDecoration(
                      color: kTertiaryColor,
                      borderRadius: BorderRadius.circular(h(context, 48)),
                    ),
                    child: Column(
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!
                              .weserveincomparabledelicacies,
                          textAlign: TextAlign.center,
                          color: kSecondaryColor,
                          fontFamily: AppFonts.Inter,
                          size: 32,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: h(context, 14)),
                        CustomText(
                          text: AppLocalizations.of(context)!
                              .allthebestrestaurantswiththeirtopmenuwaitingforyoutheycantwaitforyourorder,
                          color: kSecondaryColor,
                          fontFamily: AppFonts.Inter,
                          size: 14,
                        ),
                        SizedBox(height: h(context, 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: w(context, 24),
                              height: h(context, 6),
                              decoration: BoxDecoration(
                                color: kWhite38Color,
                                borderRadius:
                                    BorderRadius.circular(h(context, 8)),
                              ),
                            ),
                            SizedBox(width: w(context, 8)),
                            Container(
                              width: w(context, 24),
                              height: h(context, 6),
                              decoration: BoxDecoration(
                                color: kWhite38Color,
                                borderRadius:
                                    BorderRadius.circular(h(context, 8)),
                              ),
                            ),
                            SizedBox(width: w(context, 8)),
                            Container(
                              width: w(context, 24),
                              height: h(context, 6),
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius:
                                    BorderRadius.circular(h(context, 8)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h(context, 10)),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SigninScreen(
                                  userEmail: 'tehreemrizwan30@gmail.com',
                                ));
                          },
                          child: CommonImageView(
                            imagePath: Assets.imagesArrowCircle,
                            fit: BoxFit.contain,
                            height: 94,
                            width: 94,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
