import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/cart/cart_item_model.dart';
import 'package:foodapp/view/screens/home/payment_screen.dart';
import 'package:foodapp/view/widget/Custom_Textfield_widget.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryInfo extends StatefulWidget {
  final List<CartItemModel> cartItems;
  final double finalTotal;

  DeliveryInfo({required this.cartItems, required this.finalTotal});

  @override
  _DeliveryInfoState createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  // TextEditingControllers for user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _housenoController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

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
          text: "Add Shipping Information",
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
            SizedBox(height: h(context, 50)),
            CustomText(
              text: AppLocalizations.of(context)!.name,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _nameController,
              hintText: AppLocalizations.of(context)!.entername,
            ),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: AppLocalizations.of(context)!.phoneno,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _phonenumberController,
              hintText: AppLocalizations.of(context)!.enterphoneno,
            ),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: AppLocalizations.of(context)!.address,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _addressController,
              hintText: AppLocalizations.of(context)!.enteraddress,
            ),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: "House No.",
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _housenoController,
              hintText: "Enter house no.",
            ),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: "City",
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: _cityController,
              hintText: "Enter city",
            ),
            SizedBox(height: h(context, 45)),
            Center(
              child: CustomButton(
                height: 52,
                width: w(context, 327),
                buttonText: "Add Address",
                textSize: 14,
                backgroundColor: kTertiaryColor,
                onTap: () {
                  // Navigate to PaymentScreen with all user data
                  Get.to(() => PaymentScreen(
                        cartItems: widget.cartItems,
                        name: _nameController.text,
                        address: _addressController.text,
                        phone: _phonenumberController.text,
                        houseNo: _housenoController.text,
                        city: _cityController.text,
                        totalPrice: widget.finalTotal,
                      ));
                },
              ),
            ),
            SizedBox(height: h(context, 45)),
          ],
        ),
      ),
    );
  }
}
