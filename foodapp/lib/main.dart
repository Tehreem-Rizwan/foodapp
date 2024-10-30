import 'package:flutter/material.dart';
import 'package:foodapp/controllers/language_change_controller.dart';
import 'package:foodapp/view/screens/launch/onboardingScreen1.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? 'en';

  runApp(MyApp(
    initialLocale: Locale(languageCode),
  ));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageChangeController(initialLocale: initialLocale),
        ),
      ],
      child: Consumer<LanguageChangeController>(
        builder: (context, provider, child) {
          return GetMaterialApp(
            defaultTransition: Transition.fadeIn,
            locale: provider.appLocale ??
                initialLocale, // Use the locale from the provider
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('id'),
              Locale('th'),
              Locale('zh'),
            ],
            home: OnboardingScreen1(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
