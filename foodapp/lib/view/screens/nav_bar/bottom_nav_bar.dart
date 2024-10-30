import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedNavBarIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    required this.selectedNavBarIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedNavBarIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.imagesHomeicon,
            color: selectedNavBarIndex == 0 ? kTertiaryColor : kGreyColor,
          ),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.imagesBagicon,
            color: selectedNavBarIndex == 1 ? kTertiaryColor : kGreyColor,
          ),
          label: AppLocalizations.of(context)!.cart,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.imagesChaticon,
            color: selectedNavBarIndex == 2 ? kTertiaryColor : kGreyColor,
          ),
          label: AppLocalizations.of(context)!.chat,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.imagesProfileicon,
            color: selectedNavBarIndex == 3 ? kTertiaryColor : kGreyColor,
          ),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
      selectedItemColor: kTertiaryColor,
      unselectedItemColor: kSecondaryColor,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      showUnselectedLabels: true,
    );
  }
}
