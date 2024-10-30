import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/home/payment_screen.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/custom_quantity_selector_burgetwithmeat_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      padding: symmetric(context, horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const QuantitySelector(),
          SizedBox(width: w(context, 8)),
          CustomButton4(
            height: 52,
            width: w(context, 183),
            buttonText: AppLocalizations.of(context)!.addtocart,
            textSize: 14,
            backgroundColor: kTertiaryColor,
            onTap: () {
              Get.to(() => PaymentScreen());
            },
            imagePath: Assets.imagesCart,
          ),
        ],
      ),
    );
  }
}
