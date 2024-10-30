import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyOrders extends StatelessWidget {
  final String orderId;
  final String itemName;
  final String itemPrice;
  final String itemCount;
  final VoidCallback onSeeAll;

  const MyOrders({
    Key? key,
    required this.orderId,
    required this.itemName,
    required this.itemPrice,
    required this.itemCount,
    required this.onSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: all(context, 8),
      margin: only(context, top: 24, bottom: 24),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(h(context, 8)),
        boxShadow: [
          BoxShadow(
            color: kgreyblackColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: symmetric(context, horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppLocalizations.of(context)!.myorders,
                  size: 16,
                  weight: FontWeight.w600,
                  color: kBlackyColor,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onSeeAll,
                    child: CustomText(
                      text: AppLocalizations.of(context)!.seeall,
                      fontFamily: AppFonts.Inter,
                      size: 14,
                      weight: FontWeight.w600,
                      color: kTertiaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(width: w(context, 18)),
              CustomText(
                text: AppLocalizations.of(context)!.orderid,
                size: 12,
                weight: FontWeight.w600,
                color: kgreyblackColor,
              ),
              SizedBox(width: w(context, 8)),
              CustomText(
                text: orderId,
                size: 12,
                weight: FontWeight.w600,
                color: kBlackyColor,
              ),
              SizedBox(width: w(context, 90)),
              CustomButton(
                height: 27,
                width: w(context, 67),
                buttonText: AppLocalizations.of(context)!.inDelivery,
                textSize: 8,
                backgroundColor: kTertiaryColor,
                onTap: () {
                  Get.to(() => ());
                },
              ),
            ],
          ),
          Divider(color: kWhite12Color),
          ListTile(
            leading:
                Image.asset(Assets.imagesAboutthismenu, width: 52, height: 54),
            title: CustomText(
              text: itemName,
              color: kBlackyColor,
              size: 14,
              weight: FontWeight.bold,
            ),
            subtitle: CustomText(
              text: itemPrice,
              color: kTertiaryColor,
              size: 14,
              weight: FontWeight.bold,
            ),
            trailing: CustomText(
              text: itemCount,
              color: kBlackyColor,
              size: 12,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
