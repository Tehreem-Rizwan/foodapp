import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/controllers/extra_card_controller.dart';
import 'package:foodapp/view/screens/profile/extraCard/add_card1.dart';
import 'package:foodapp/view/screens/profile/extraCard/delete_dialogue.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_payment_method_card.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExtraCardPage extends StatelessWidget {
  final ExtraCardController controller = Get.put(ExtraCardController());

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
        actions: [
          Padding(
            padding: only(context, right: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kWhite12Color),
              ),
              child: IconButton(
                icon: const Image(
                  image: AssetImage(Assets.imagesDeleteicon),
                  color: kRedColor,
                ),
                onPressed: () {
                  DeleteDialogue.show(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: only(context, left: 24, right: 24, top: 20, bottom: 20),
        child: Column(
          children: [
            CommonImageView(
              imagePath: Assets.imagesSoCard,
              height: 215,
              width: 327,
              fit: BoxFit.contain,
            ),
            SizedBox(height: h(context, 24)),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: AppLocalizations.of(context)!.creditcard,
                size: 16,
                weight: FontWeight.w500,
                color: kBlackyColor,
              ),
            ),
            SizedBox(height: h(context, 16)),
            Obx(() => GestureDetector(
                  onTap: () {
                    controller.selectPaymentMethod(0);
                  },
                  child: PaymentMethodCard(
                    iconPath: Assets.imagesExtracard,
                    title: AppLocalizations.of(context)!.mastercard,
                    number: '**** **** 0783 7873',
                    brandIconPath: Assets.imagesMastercard,
                    isSelected: controller.selectedIndex.value == 0,
                  ),
                )),
            Obx(() => GestureDetector(
                  onTap: () {
                    controller.selectPaymentMethod(
                        1); // Set selected index for Paypal
                  },
                  child: PaymentMethodCard(
                    iconPath: Assets.imagesExtracard,
                    title: AppLocalizations.of(context)!.paypal,
                    number: '**** **** 0582 4672',
                    brandIconPath: Assets.imagesPaypal,
                    isSelected: controller.selectedIndex.value == 1,
                  ),
                )),
            Obx(() => GestureDetector(
                  onTap: () {
                    controller.selectPaymentMethod(2);
                  },
                  child: PaymentMethodCard(
                    iconPath: Assets.imagesExtracard,
                    title: AppLocalizations.of(context)!.applepay,
                    number: '**** **** 0582 4672',
                    brandIconPath: Assets.imagesApplepay,
                    isSelected: controller.selectedIndex.value == 2,
                  ),
                )),
            Spacer(),
            Center(
              child: CustomButton(
                height: 52,
                width: w(context, 327),
                buttonText: AppLocalizations.of(context)!.addnewcard,
                textSize: 14,
                backgroundColor: kTertiaryColor,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: double.infinity,
                          height: h(context, 510),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(h(context, 28)),
                              topRight: Radius.circular(h(context, 28)),
                            ),
                            color: kSecondaryColor,
                          ),
                          child: AddCardPage1());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
