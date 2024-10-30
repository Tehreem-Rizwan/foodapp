import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English (US)'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  void changeLanguage(String language, Locale locale) async {
    selectedLanguage.value = language;
    Get.updateLocale(locale);

    // Save the selected language in SharedPreferences
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('language_code', locale.languageCode);
  }

  void _loadLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String languageCode =
        sp.getString('language_code') ?? 'en'; // Default to English

    switch (languageCode) {
      case 'id':
        selectedLanguage.value = 'Indonesia';
        Get.updateLocale(Locale('id'));
        break;
      case 'th':
        selectedLanguage.value = 'Thailand';
        Get.updateLocale(Locale('th'));
        break;
      case 'zh':
        selectedLanguage.value = 'Chinese';
        Get.updateLocale(Locale('zh'));
        break;
      case 'en':
      default:
        selectedLanguage.value = 'English (US)';
        Get.updateLocale(Locale('en'));
        break;
    }
  }
}
