import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/view/screens/launch/auth/signin_screen.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignOutDialog extends StatelessWidget {
  final AuthController authController =
      Get.put(AuthController()); // Inject AuthController

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      backgroundColor: kTransparentColor,
      content: Padding(
        padding: all(context, 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(h(context, 12)),
          ),
          height: h(context, 184),
          width: w(context, 340),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.signOut,
                      size: 24,
                      weight: FontWeight.bold,
                      color: kBlackyColor,
                    ),
                    IconButton(
                      icon: Image.asset(
                        Assets.imagesEndcall,
                        width: 20,
                        height: 20,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: h(context, 16)),
              CustomText(
                text: AppLocalizations.of(context)!.doyouwanttologout,
                size: 14,
                weight: FontWeight.w500,
                color: kgreyblackColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h(context, 24)),
              Padding(
                padding: all(context, 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton3(
                      height: h(context, 40),
                      onTap: () {
                        Get.back();
                      },
                      buttonText: '',
                      textColor: kBlackyColor,
                      textSize: 14,
                      width: w(context, 120),
                      child: CustomText(
                        text: AppLocalizations.of(context)!.cancel,
                        size: 14,
                        color: kBlackyColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: w(context, 12)),
                    CustomButton4(
                      height: h(context, 40),
                      buttonText: AppLocalizations.of(context)!.logout,
                      textSize: 14,
                      backgroundColor: kTertiaryColor,
                      onTap: () async {
                        await authController.signOut(); // Sign out the user
                        Get.offAll(() => SigninScreen(
                              userEmail: 'tehreemrizwan30@gmail.com',
                            )); // Navigate to SigninScreen after sign out
                      },
                      width: w(context, 120),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SignOutDialog();
      },
    );
  }
}
