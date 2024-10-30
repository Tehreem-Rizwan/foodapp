import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/controllers/registration_controller.dart';
import 'package:foodapp/view/screens/launch/auth/signin_screen.dart';
import 'package:foodapp/view/widget/Custom_Textfield_widget.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_social_button_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(context, 62)),
              CustomText(
                text: AppLocalizations.of(context)!.createyournewaccount,
                size: 32,
                weight: FontWeight.w800,
                color: kBlackyColor,
                fontFamily: AppFonts.Inter,
              ),
              SizedBox(height: h(context, 8)),
              CustomText(
                text:
                    'Create an account to start looking for the food\nyou like',
                size: 14,
                weight: FontWeight.w500,
                color: kgreyblackColor,
                fontFamily: AppFonts.Inter,
              ),
              SizedBox(height: h(context, 18)),
              CustomText(
                text: AppLocalizations.of(context)!.emailaddress,
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomTextField(
                controller: controller.emailController,
                hintText: AppLocalizations.of(context)!.enterEmail,
              ),
              SizedBox(height: h(context, 12)),
              CustomText(
                text: AppLocalizations.of(context)!.username,
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomTextField(
                controller: controller.userNameController,
                hintText: AppLocalizations.of(context)!.enterusername,
              ),
              SizedBox(height: h(context, 12)),
              CustomText(
                text: AppLocalizations.of(context)!.password,
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomTextField(
                controller: controller.passwordController,
                hintText: AppLocalizations.of(context)!.password,
                obscureText: true,
                isIcon: true,
              ),
              SizedBox(height: h(context, 28)),
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: controller.isChecked.value,
                        onChanged: (value) {
                          controller.isChecked.value = value ?? true;
                        },
                        activeColor: kTertiaryColor,
                      )),
                  Expanded(
                    child: Wrap(
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!.iagreewith,
                          size: 14,
                          weight: FontWeight.w500,
                          color: kBlackyColor,
                          fontFamily: AppFonts.Inter,
                        ),
                        CustomText(
                          text: AppLocalizations.of(context)!.termsofserivce,
                          size: 14,
                          fontFamily: AppFonts.Inter,
                          weight: FontWeight.bold,
                          color: kTertiaryColor,
                        ),
                        CustomText(
                          text: AppLocalizations.of(context)!.and,
                          size: 14,
                          color: kBlackyColor,
                          fontFamily: AppFonts.Inter,
                        ),
                        CustomText(
                          text: AppLocalizations.of(context)!.privacy,
                          size: 14,
                          weight: FontWeight.bold,
                          color: kTertiaryColor,
                          fontFamily: AppFonts.Inter,
                        ),
                        CustomText(
                          text: AppLocalizations.of(context)!.policy,
                          size: 14,
                          weight: FontWeight.bold,
                          color: kTertiaryColor,
                          fontFamily: AppFonts.Inter,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: h(context, 30)),
              Center(
                child: CustomButton(
                  height: 52,
                  width: 327,
                  buttonText: AppLocalizations.of(context)!.register,
                  textSize: 14,
                  backgroundColor: kTertiaryColor,
                  onTap: controller.register,
                ),
              ),
              SizedBox(height: h(context, 30)),
              Row(
                children: [
                  Expanded(child: Divider(color: kgreyblackColor)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: CustomText(
                      text: AppLocalizations.of(context)!.orsigninwith,
                      fontFamily: AppFonts.Inter,
                      size: 14,
                      weight: FontWeight.w500,
                      color: kgreyblackColor,
                    ),
                  ),
                  Expanded(child: Divider(color: kgreyblackColor)),
                ],
              ),
              SizedBox(height: h(context, 22)),
              Row(
                children: [
                  SizedBox(width: 90),
                  SocialButton(
                    asset: Assets.imagesGoogle,
                    onTap: () async {},
                  ),
                  SizedBox(width: 20),
                  SocialButton(
                    asset: Assets.imagesFacebook,
                    onTap: () async {},
                  ),
                  SizedBox(width: 20),
                  SocialButton(
                    asset: Assets.imagesApple,
                    onTap: () async {},
                  ),
                ],
              ),
              SizedBox(height: h(context, 32)),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.donthaveanaccount,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kBlackyColor,
                      fontFamily: AppFonts.Inter,
                    ),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.signin,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kTertiaryColor,
                          fontFamily: AppFonts.Inter,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => SigninScreen(
                                  userEmail: 'tehreemrizwan30@gmail.com',
                                ));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
