import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_delievery_time_widget.dart';
import 'package:foodapp/view/widget/custom_driver_info_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        children: [
          CommonImageView(
              imagePath: Assets.imagesMapsicleMap,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 532),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: symmetric(context, horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: all(context, 8),
                        decoration: BoxDecoration(
                          color: kTertiaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: kSecondaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: w(context, 70)),
                      CustomText(
                        text: AppLocalizations.of(context)!.delieverdyourorder,
                        size: 16,
                        weight: FontWeight.w600,
                        color: kBlackyColor,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                DriverInfoWidget(
                  driverName: AppLocalizations.of(context)!.cristopertDastin,
                  driverId: '213752',
                  driverImage: Assets.imagesCristopertDastin,
                  messageIcon: Assets.imagesMsg,
                  callIcon: Assets.imagesPhonecall,
                ),
                DeliveryTimeWidget(
                  deliveryText: AppLocalizations.of(context)!.yourDeliveryTime,
                  estimatedTime:
                      AppLocalizations.of(context)!.estimated830915PM,
                  primaryColor: kBlackyColor,
                  secondaryColor: kgreyblackColor,
                ),
                CommonImageView(
                    imagePath: Assets.imagesProgress,
                    fit: BoxFit.contain,
                    width: 327,
                    height: 24),
                SizedBox(height: h(context, 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.order,
                      size: 14,
                      weight: FontWeight.w600,
                      color: kBlackyColor,
                    ),
                  ],
                ),
                Padding(
                  padding: all(context, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context)!.burger2WithMeat,
                        size: 14,
                        color: kgreyblackColor,
                      ),
                      CustomText(
                        text: '\$283',
                        size: 14,
                        color: kgreyblackColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h(context, 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
