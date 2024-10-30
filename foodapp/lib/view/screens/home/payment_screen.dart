import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_address_item_payment.dart';
import 'package:foodapp/view/widget/custom_detail_item_payment.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatelessWidget {
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
                color: kWhite12Color,
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
          text: AppLocalizations.of(context)!.payment,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 24, vertical: 20),
        child: ListView(
          children: [
            CustomText(
              text: AppLocalizations.of(context)!.youdeservebettermeal,
              size: 14,
              weight: FontWeight.w300,
              color: kgreyblackColor,
            ),
            SizedBox(height: h(context, 10)),
            CustomText(
              text: AppLocalizations.of(context)!.itemordered,
              size: 16,
              weight: FontWeight.w600,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 16)),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      h(context, 12.0)), // Adjust the radius value as needed
                  child: CommonImageView(
                    imagePath: Assets.imagesAboutthismenu,
                    width: 80,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: w(context, 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context)!.burgerWithMeat,
                        size: 16,
                        weight: FontWeight.w600,
                        color: kBlackyColor,
                      ),
                      SizedBox(height: h(context, 8)),
                      CustomText(
                        text: "\$ 12,230",
                        size: 14,
                        weight: FontWeight.w700,
                        color: kTertiaryColor,
                      ),
                    ],
                  ),
                ),
                CustomText(
                  text: AppLocalizations.of(context)!.items14,
                  size: 12,
                  weight: FontWeight.w500,
                  color: kgreyblackColor,
                ),
              ],
            ),
            SizedBox(height: h(context, 16)),
            SizedBox(height: h(context, 16)),
            CustomText(
              text: AppLocalizations.of(context)!.detailstransaction,
              size: 16,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(
              height: h(context, 10),
            ),
            Column(
              children: [
                DetailItem(
                    name: AppLocalizations.of(context)!.cherryhealthy,
                    price: "\$ 180.000"),
                SizedBox(
                  height: h(context, 5),
                ),
                DetailItem(
                    name: AppLocalizations.of(context)!.driver,
                    price: "\$ 50.000"),
                SizedBox(
                  height: h(context, 5),
                ),
                DetailItem(
                    name: AppLocalizations.of(context)!.tax10,
                    price: "\$ 80.390"),
                SizedBox(
                  height: h(context, 5),
                ),
                DetailItem(
                    name: AppLocalizations.of(context)!.totalprice,
                    price: "\$ 100.000",
                    highlight: true), // Using highlight for total
              ],
            ),
            SizedBox(height: h(context, 16)),
            Divider(
              color: kWhite12Color,
              thickness: 2,
            ),
            SizedBox(height: h(context, 16)),
            CustomText(
              text: AppLocalizations.of(context)!.delieverto,
              size: 16,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(
              height: h(context, 10),
            ),
            AddressItem(
                label: AppLocalizations.of(context)!.name,
                value: AppLocalizations.of(context)!.albertStevanoBajefski),
            SizedBox(
              height: h(context, 5),
            ),
            AddressItem(
                label: AppLocalizations.of(context)!.phoneno,
                value: "+12 8347 2838 28"),
            SizedBox(
              height: h(context, 5),
            ),
            AddressItem(
                label: AppLocalizations.of(context)!.address,
                value: AppLocalizations.of(context)!.newyork),
            SizedBox(
              height: h(context, 5),
            ),
            AddressItem(
                label: AppLocalizations.of(context)!.houseno,
                value: AppLocalizations.of(context)!.bC54Berlin),
            SizedBox(
              height: h(context, 5),
            ),
            AddressItem(
                label: AppLocalizations.of(context)!.city,
                value: AppLocalizations.of(context)!.newyorkcity),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: symmetric(context, horizontal: 24, vertical: 16),
        child: CustomButton(
          height: 52,
          width: w(context, 327),
          buttonText: AppLocalizations.of(context)!.checkoutnow,
          textSize: 14,
          backgroundColor: kTertiaryColor,
          onTap: () {
            Get.to(() => ());
          },
        ),
      ),
    );
  }
}
