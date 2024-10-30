import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/profile/extraCard/add_card2.dart';
import 'package:foodapp/view/screens/profile/extraCard/extra_card.dart';
import 'package:foodapp/view/screens/profile/help_center.dart';
import 'package:foodapp/view/screens/profile/personal_data_page.dart';
import 'package:foodapp/view/screens/profile/settings.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: only(context, right: 260),
          child: CustomText(
            text: AppLocalizations.of(context)!.pRofile,
            size: 14,
            color: kgreyblackColor,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: h(context, 10),
        ),
        MenuItem(
          label: AppLocalizations.of(context)!.personalData,
          iconPath: Assets.imagesProfilesettingsicon,
          onTap: () {
            Get.to(() => PersonalDataPage());
          },
        ),
        MenuItem(
          label: AppLocalizations.of(context)!.settings,
          iconPath: Assets.imagesSettings,
          onTap: () {
            Get.to(() => Settings());
          },
        ),
        MenuItem(
          label: AppLocalizations.of(context)!.extraCard,
          iconPath: Assets.imagesExtracard,
          onTap: () {
            Get.to(() => ExtraCardPage());
          },
        ),
        SizedBox(
          height: h(context, 10),
        ),
        Padding(
          padding: only(context, right: 260),
          child: CustomText(
            text: AppLocalizations.of(context)!.support,
            size: 14,
            color: kgreyblackColor,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: h(context, 10),
        ),
        MenuItem(
          label: AppLocalizations.of(context)!.helpCenter,
          iconPath: Assets.imagesHelpcenter,
          onTap: () {
            Get.to(() => HelpCenterPage());
          },
        ),
        MenuItem(
          label: AppLocalizations.of(context)!.requestAccountDeletion,
          iconPath: Assets.imagesRequestaccountdeletion,
          onTap: () {},
        ),
        MenuItem(
          label: AppLocalizations.of(context)!.addanotheraccount,
          iconPath: Assets.imagesAddanotheraccount,
          onTap: () {
            Get.to(() => AddCardForm());
          },
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.label,
    required this.iconPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: w(context, 32),
        height: h(context, 32),
        decoration: BoxDecoration(
          color: kwhite34Color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(iconPath, width: 20, height: 20),
        ),
      ),
      title: CustomText(
        text: label,
        size: 14,
        weight: FontWeight.bold,
        color: kBlackyColor,
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: kBlackyColor),
      onTap: onTap,
    );
  }
}
