import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/controllers/language_controller.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_language_item_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelectionPage extends StatelessWidget {
  final Function(String) onLanguageSelected;

  LanguageSelectionPage({required this.onLanguageSelected});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());

    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        children: [
          Padding(
            padding: symmetric(context, horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: h(context, 16)),
                  CustomText(
                    text: AppLocalizations.of(context)!.selectLanguage,
                    size: 16,
                    weight: FontWeight.w600,
                    color: kBlackyColor,
                  ),
                  SizedBox(height: h(context, 24)),

                  Obx(() => LanguageItemWidget(
                        flag: '🇮🇩',
                        language: AppLocalizations.of(context)!.indoesia,
                        isSelected: languageController.selectedLanguage.value ==
                            AppLocalizations.of(context)!.indoesia,
                        onTap: () {
                          languageController.changeLanguage(
                              AppLocalizations.of(context)!.indoesia,
                              Locale('id'));
                        },
                      )),
                  // English Language Item
                  Obx(() => LanguageItemWidget(
                        flag: '🇺🇸',
                        language: AppLocalizations.of(context)!.englishus,
                        isSelected: languageController.selectedLanguage.value ==
                            AppLocalizations.of(context)!.englishus,
                        onTap: () {
                          languageController.changeLanguage(
                              AppLocalizations.of(context)!.englishus,
                              Locale('en'));
                        },
                      )),
                  // Thailand Language Item
                  Obx(() => LanguageItemWidget(
                        flag: '🇹🇭',
                        language: AppLocalizations.of(context)!.thailand,
                        isSelected: languageController.selectedLanguage.value ==
                            AppLocalizations.of(context)!.thailand,
                        onTap: () {
                          languageController.changeLanguage(
                              AppLocalizations.of(context)!.thailand,
                              Locale('th'));
                        },
                      )),
                  Obx(() => LanguageItemWidget(
                        flag: '🇨🇳',
                        language: AppLocalizations.of(context)!.chinese,
                        isSelected: languageController.selectedLanguage.value ==
                            AppLocalizations.of(context)!.chinese,
                        onTap: () {
                          languageController.changeLanguage(
                              AppLocalizations.of(context)!.chinese,
                              Locale('zh'));
                        },
                      )),
                  SizedBox(height: h(context, 10)),
                  Center(
                    child: CustomButton(
                      height: 52,
                      width: w(context, 327),
                      buttonText: AppLocalizations.of(context)!.select,
                      textSize: 14,
                      backgroundColor: kTertiaryColor,
                      onTap: () {
                        onLanguageSelected(
                            languageController.selectedLanguage.value);
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
