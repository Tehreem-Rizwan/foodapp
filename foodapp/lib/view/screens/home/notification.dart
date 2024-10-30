import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_notification_item_widget.dart';
import 'package:foodapp/view/widget/custom_section_header_notification.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
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
            padding: symmetric(context, horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: klightbluecolor,
              ),
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
          text: AppLocalizations.of(context)!.notification,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 24),
        child: ListView(
          children: [
            SizedBox(height: h(context, 20)),
            SectionHeader(title: AppLocalizations.of(context)!.today),
            NotificationItem(
              iconPath: Assets.imagesDiscount,
              title: AppLocalizations.of(context)!.special30Discount,
              subtitle:
                  AppLocalizations.of(context)!.specialpromotiononlyvalidtoday,
            ),
            NotificationItem(
              iconPath: Assets.imagesGreentick,
              title: AppLocalizations.of(context)!
                  .yourOrderHasBeenTakenbytheDriver,
              subtitle: AppLocalizations.of(context)!.recently,
            ),
            Divider(
              color: kWhite12Color,
            ),
            NotificationItem(
              iconPath: Assets.imagesCancelled,
              title: AppLocalizations.of(context)!.yourOrderHasBeenCanceled,
              subtitle: AppLocalizations.of(context)!.jun192023,
            ),
            SizedBox(
              height: h(context, 40),
            ),
            SizedBox(
              width: double.infinity,
              child: Divider(
                thickness: 5,
                color: kWhite12Color,
              ),
            ),
            SectionHeader(title: AppLocalizations.of(context)!.yesterday),
            NotificationItem(
              iconPath: Assets.imagesPromotion,
              title: AppLocalizations.of(context)!.special30Discount,
              subtitle: AppLocalizations.of(context)!
                  .specialpromotiononlyvalidyesterday,
            ),
            Divider(
              color: kWhite12Color,
            ),
            NotificationItem(
              iconPath: Assets.imagesAccount,
              title: AppLocalizations.of(context)!.accountSetupSuccessful,
              subtitle:
                  AppLocalizations.of(context)!.setupwassuccessfulyesterday,
            ),
            Divider(
              color: kWhite12Color,
            ),
            NotificationItem(
              iconPath: Assets.imagesDiscount,
              title: AppLocalizations.of(context)!.specialOffer60Off,
              subtitle: AppLocalizations.of(context)!
                  .specialofferfornewaccountsvaliduntil20Nov2022,
            ),
            Divider(
              color: kWhite12Color,
            ),
            NotificationItem(
              iconPath: Assets.imagesCreditcard,
              title: AppLocalizations.of(context)!.creditCardConnected,
              subtitle:
                  AppLocalizations.of(context)!.specialpromotiononlyvalidtoday,
            ),
            Divider(
              color: kWhite12Color,
            ),
          ],
        ),
      ),
    );
  }
}
