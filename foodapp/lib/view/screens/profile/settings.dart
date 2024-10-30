import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_settings_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
            text: AppLocalizations.of(context)!.settings,
            color: kBlackyColor,
            size: 16,
            fontFamily: AppFonts.Inter,
            weight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: symmetric(context, horizontal: 10, vertical: 10),
          child: MenuSectionSettings(),
        ));
  }
}
