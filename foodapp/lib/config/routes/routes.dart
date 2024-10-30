// ignore_for_file: constant_identifier_names

import 'package:foodapp/view/screens/launch/onboardingScreen1.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: AppLinks.Loading,
      page: () => OnboardingScreen1(),
    ),
  ];
}

class AppLinks {
  static const Loading = '/Loading';
}
