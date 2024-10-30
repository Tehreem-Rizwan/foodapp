import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_Textfield_widget.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_drop_down_card_type.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCardForm extends StatelessWidget {
  final TextEditingController nameoncardController = TextEditingController();
  final TextEditingController cardnumberController = TextEditingController();
  final TextEditingController cardtypeController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final TextEditingController expirydateController = TextEditingController();
  final TextEditingController billingaddressController =
      TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kWhite12Color),
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
          text: AppLocalizations.of(context)!.extraCard,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: only(context, left: 24, right: 24),
        child: ListView(
          children: [
            SizedBox(height: h(context, 30)),
            CustomText(
              text: AppLocalizations.of(context)!.nameoncard,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: nameoncardController,
              hintText: AppLocalizations.of(context)!.entername,
            ),
            SizedBox(height: h(context, 8)),
            CustomText(
              text: AppLocalizations.of(context)!.cardnumber,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: cardnumberController,
              hintText: '_ _ _ _  /  _ _ _ _  /  _ _ _ _  /  _ _ _ _',
            ),
            SizedBox(height: h(context, 8)),
            CustomDropdownField(
              text: AppLocalizations.of(context)!.cardnumber,
              hinttext: AppLocalizations.of(context)!.selectcardtype,
              items: [
                AppLocalizations.of(context)!.visa,
                AppLocalizations.of(context)!.mastercard,
                AppLocalizations.of(context)!.paypal,
                AppLocalizations.of(context)!.applepay,
              ],
            ),
            SizedBox(height: h(context, 8)),
            CustomText(
              text: AppLocalizations.of(context)!.expirydate,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: expirydateController,
              hintText: 'MM  /  YY',
            ),
            SizedBox(height: h(context, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppLocalizations.of(context)!.cvv,
                  size: 14,
                  weight: FontWeight.w700,
                  color: kBlackyColor,
                ),
                CommonImageView(
                  imagePath: Assets.imagesCvv,
                  height: 18,
                  width: 18,
                  fit: BoxFit.contain,
                )
              ],
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: cvvController,
              hintText: "_ _ _ _ _",
            ),
            SizedBox(height: h(context, 8)),
            CustomText(
              text: AppLocalizations.of(context)!.billingaddress,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: billingaddressController,
              hintText: AppLocalizations.of(context)!.enteraddress,
            ),
            SizedBox(height: h(context, 50)),
            Center(
              child: CustomButton(
                height: 52,
                width: w(context, 327),
                buttonText: AppLocalizations.of(context)!.savecard,
                textSize: 14,
                backgroundColor: kTertiaryColor,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
