import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/cart/cart_item_model.dart';
import 'package:foodapp/view/screens/cart/delievery_info.dart';
import 'package:foodapp/view/screens/cart/order_delivery.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_cart_item_widget.dart';
import 'package:foodapp/view/widget/custom_paymetn_summary_widget.dart';
import 'package:foodapp/view/widget/custom_promo_code_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widget/custom_recommended_section_widget_burget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItemModel> cartItems = [
    CartItemModel(
      imagePath: Assets.imagesBurgerwithmeat,
      name: 'Burger with Meat',
      price: 12230,
    ),
    CartItemModel(
      imagePath: Assets.imagesAboutthismenu,
      name: 'Ordinary Burger',
      price: 12230,
    ),
    CartItemModel(
      imagePath: Assets.imagesBurgerwithbeef,
      name: 'Burger with Beef',
      price: 12230,
    ),
  ];

  double deliveryFee = 0;
  double discount = 10900;

  // Calculate the total items cost based on selected items and quantities
  double get totalItemsCost {
    return cartItems
        .where((item) => item.isChecked) // Only checked items
        .fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  // Calculate the final total (after discount)
  double get finalTotal {
    return totalItemsCost - discount + deliveryFee;
  }

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
                Get.back(); // Navigate back
              },
            ),
          ),
        ),
        title: CustomText(
          text: AppLocalizations.of(context)!.mycart,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kWhite12Color),
              ),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Image(
                  image: AssetImage(Assets.imagesThreedots),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: AppLocalizations.of(context)!.deliverylocation,
                    size: 14,
                    weight: FontWeight.w400,
                    color: kgreyblackColor,
                  ),
                  SizedBox(height: h(context, 4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context)!.home,
                        size: 14,
                        weight: FontWeight.w600,
                        color: kBlackyColor,
                      ),
                      CustomButton5(
                        height: 32,
                        width: w(context, 109),
                        buttonText:
                            AppLocalizations.of(context)!.changelocation,
                        textSize: 12,
                        backgroundColor: kTransparentColor,
                        onTap: () {
                          Get.to(() => DeliveryOrderScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: h(context, 16)),
              PromoCodeWidget(), // Promo code entry section
              SizedBox(height: h(context, 24)),
              ...cartItems.map((item) => CartItemWidget(
                    cartItem: item,
                    onChanged: () {
                      setState(() {});
                    },
                  )),
              SizedBox(height: h(context, 16)),
              RecommendedSectionWidget(), // Recommended items section
              SizedBox(height: h(context, 16)),
              PaymentSummaryWidget(
                totalItemsCost: totalItemsCost,
                deliveryFee: deliveryFee,
                discount: discount,
                finalTotal: finalTotal,
              ),
              SizedBox(height: h(context, 24)),
              Center(
                child: CustomButton(
                  height: 52,
                  width: w(context, 327),
                  buttonText: AppLocalizations.of(context)!.ordernow,
                  textSize: 14,
                  backgroundColor: kTertiaryColor,
                  onTap: () {
                    List<CartItemModel> selectedItems =
                        cartItems.where((item) => item.isChecked).toList();

                    Get.to(() => DeliveryInfo(
                        cartItems: selectedItems, finalTotal: finalTotal));
                  },
                ),
              ),
              SizedBox(height: h(context, 24)),
            ],
          ),
        ),
      ),
    );
  }
}
