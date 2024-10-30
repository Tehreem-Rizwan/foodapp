import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/screens/cart/cart_item_model.dart';
import 'package:foodapp/view/screens/services/firebase_services.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';

import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:io';

class PaymentScreen extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final String name;
  final String phone;
  final String address;
  final String houseNo;
  final String city;
  final double totalPrice;

  final FirebaseService _firebaseService = FirebaseService();

  PaymentScreen({
    required this.cartItems,
    required this.name,
    required this.phone,
    required this.address,
    required this.houseNo,
    required this.city,
    required this.totalPrice,
  });
  Future<void> _checkoutNow() async {
    List<CartItemModel> updatedCartItems = [];

    for (var item in cartItems) {
      File imageFile = File(item.imagePath); // Convert image path to File
      String imageUrl = await _firebaseService.uploadImage(imageFile);

      updatedCartItems.add(CartItemModel(
        imagePath: imageUrl,
        name: name,
        price: totalPrice,
      ));
    }

    // Store the order data in Firestore using the updated list
    await _firebaseService.storeOrderData(
      cartItems: updatedCartItems,
      name: name,
      phone: phone,
      address: address,
      houseNo: houseNo,
      city: city,
      totalPrice: totalPrice,
    );

    // Show success message or navigate to another screen after successful order placement
    Get.snackbar('Order Successful', 'Your order has been placed.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI code remains unchanged
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: CustomButton(
          height: 52,
          width: 327,
          buttonText: AppLocalizations.of(context)!.checkoutnow,
          textSize: 14,
          backgroundColor: kTertiaryColor,
          onTap: _checkoutNow,
        ),
      ),
    );
  }
}
