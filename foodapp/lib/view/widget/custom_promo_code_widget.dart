import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PromoCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryColor,
              border: Border.all(color: Color(0xFFEDEDED), width: 1),
              borderRadius: BorderRadius.circular(h(context, 100)),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Row(
                  children: [
                    SizedBox(width: w(context, 10)),
                    Image(
                      image: AssetImage(Assets.imagesLocaloffer),
                    ),
                    SizedBox(width: w(context, 8)),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.promoCode,
                          hintStyle: TextStyle(
                            fontSize: f(context, 14),
                            fontWeight: FontWeight.w500,
                            color: kWhite38Color,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: w(context, 10),
                  child: CustomButton(
                    height: 32,
                    width: w(context, 75),
                    buttonText: AppLocalizations.of(context)!.apply,
                    textSize: 14,
                    backgroundColor: kTertiaryColor,
                    onTap: () {
                      Get.to(() => ());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: w(context, 8)),
      ],
    );
  }
}
