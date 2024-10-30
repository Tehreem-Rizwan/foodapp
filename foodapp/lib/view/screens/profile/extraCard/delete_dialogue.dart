import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteDialogue extends StatelessWidget {
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      backgroundColor: kTransparentColor,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(h(context, 12)),
          ),
          height: h(context, 200),
          width: w(context, 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.confirmdelete,
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
                text: AppLocalizations.of(context)!.areyousuretodeletethiscard,
                size: 14,
                weight: FontWeight.w500,
                color: kgreyblackColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h(context, 24)),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton4(
                      height: h(context, 40),
                      buttonText: AppLocalizations.of(context)!.noIwont,
                      textSize: 14,
                      backgroundColor: kTertiaryColor,
                      onTap: () {
                        Get.back();
                      },
                      width: w(context, 120),
                    ),
                    SizedBox(width: w(context, 12)),
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
                        text: AppLocalizations.of(context)!.yesofcourse,
                        size: 14,
                        color: kBlackyColor,
                        weight: FontWeight.bold,
                      ),
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
        return DeleteDialogue();
      },
    );
  }
}
