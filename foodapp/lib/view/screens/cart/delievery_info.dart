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

  // Error messages for validation
  String? _nameError;
  String? _phoneError;
  String? _addressError;
  String? _houseNoError;
  String? _cityError;

  // Function to validate the form
  bool _validateForm() {
    setState(() {
      _nameError = _nameController.text.isEmpty
          ? 'This field should not be empty, fill it.'
          : null;
      _phoneError = _phonenumberController.text.isEmpty
          ? 'This field should not be empty, fill it.'
          : null;
      _addressError = _addressController.text.isEmpty
          ? 'This field should not be empty, fill it.'
          : null;
      _houseNoError = _housenoController.text.isEmpty
          ? 'This field should not be empty, fill it.'
          : null;
      _cityError = _cityController.text.isEmpty
          ? 'This field should not be empty, fill it.'
          : null;
    });

    // Return true if all fields are valid (no errors)
    return _nameError == null &&
        _phoneError == null &&
        _addressError == null &&
        _houseNoError == null &&
        _cityError == null;
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
            if (_nameError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(_nameError!, style: TextStyle(color: Colors.red)),
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
            if (_phoneError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(_phoneError!, style: TextStyle(color: Colors.red)),
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
            if (_addressError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child:
                    Text(_addressError!, style: TextStyle(color: Colors.red)),
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
            if (_houseNoError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child:
                    Text(_houseNoError!, style: TextStyle(color: Colors.red)),
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
            if (_cityError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(_cityError!, style: TextStyle(color: Colors.red)),
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
                  if (_validateForm()) {
                    Get.to(() => PaymentScreen(
                          cartItems: widget.cartItems,
                          name: _nameController.text,
                          address: _addressController.text,
                          phone: _phonenumberController.text,
                          houseNo: _housenoController.text,
                          city: _cityController.text,
                          finalTotal: widget.finalTotal,
                        ));
                  }
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
