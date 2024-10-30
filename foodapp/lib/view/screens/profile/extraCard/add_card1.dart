import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_card_input_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCardPage1 extends StatelessWidget {
  final TextEditingController cardholderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SingleChildScrollView(
        padding: only(context, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonImageView(
              imagePath: Assets.imagesVisa,
              height: 176,
              width: 327,
              fit: BoxFit.contain,
            ),
            CustomInputField(
              label: AppLocalizations.of(context)!.cardholdername,
              placeholder: AppLocalizations.of(context)!.albertStevanoBajefski,
              controller: cardholderController,
            ),
            CustomInputField(
              label: AppLocalizations.of(context)!.cardnumber,
              placeholder: '3822 8293 8292 2356',
              withIcon: true,
              controller: cardNumberController,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    label: AppLocalizations.of(context)!.expirydate,
                    placeholder: '11/24',
                    controller: expiryDateController,
                  ),
                ),
                SizedBox(width: w(context, 8)),
                Expanded(
                  child: CustomInputField(
                    label: AppLocalizations.of(context)!.digit3CVV,
                    placeholder: '531',
                    controller: cvvController,
                  ),
                ),
              ],
            ),
            SizedBox(height: h(context, 18)),
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
