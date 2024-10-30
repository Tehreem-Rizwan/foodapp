import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {
  Locale? _appLocale;

  // Getter to access the current app locale
  Locale? get appLocale => _appLocale;

  // Constructor to load the saved language
  LanguageChangeController({Locale? initialLocale}) {
    _appLocale = initialLocale; // Set the initial locale if provided
    _loadLocale(); // Load saved locale from SharedPreferences
  }

  // Method to change the language and save the preference
  void changeLanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _appLocale = type;

    // Save the language code in SharedPreferences
    await sp.setString('language_code', type.languageCode);

    // Update the GetX locale for immediate language change
    Get.updateLocale(_appLocale!);

    notifyListeners(); // Notify listeners to rebuild UI with new locale
  }

  // Method to load the saved locale from SharedPreferences
  void _loadLocale() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode =
        sp.getString('language_code') ?? 'en'; // Default to English

    // Set the appLocale based on the saved preference
    _appLocale = Locale(languageCode);
    notifyListeners(); // Notify listeners after loading the saved locale
  }
}
