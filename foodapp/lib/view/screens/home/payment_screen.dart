import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/view/screens/cart/cart_item_model.dart';
import 'package:foodapp/view/screens/cart/cart_screen.dart';
import 'package:foodapp/view/screens/home/notification/notification_services.dart';
import 'package:foodapp/view/screens/home/notification/send_notification_service.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_address_item_payment.dart';
import 'package:foodapp/view/widget/custom_detail_item_payment.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final String name;
  final String phone;
  final String address;
  final String houseNo;
  final String city;
  final double finalTotal;

  PaymentScreen({
    required this.cartItems,
    required this.name,
    required this.phone,
    required this.address,
    required this.houseNo,
    required this.city,
    required this.finalTotal,
    required paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
              size: 16,
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
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ListView(
          children: [
            CustomText(
              text: AppLocalizations.of(context)!.youdeservebettermeal,
              size: 14,
              weight: FontWeight.w300,
              color: kgreyblackColor,
            ),
            SizedBox(height: 10),
            CustomText(
              text: AppLocalizations.of(context)!.itemordered,
              size: 16,
              weight: FontWeight.w600,
              color: kBlackyColor,
            ),
            SizedBox(height: 16),
            ...cartItems.map((item) => buildCartItem(item)).toList(),
            SizedBox(height: 16),
            CustomText(
              text: AppLocalizations.of(context)!.detailstransaction,
              size: 16,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: 10),
            buildTransactionDetails(),
            SizedBox(height: 16),
            Divider(color: kWhite12Color, thickness: 2),
            SizedBox(height: 16),
            CustomText(
              text: AppLocalizations.of(context)!.delieverto,
              size: 16,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: 10),
            AddressItem(label: AppLocalizations.of(context)!.name, value: name),
            SizedBox(height: 5),
            AddressItem(
                label: AppLocalizations.of(context)!.phoneno, value: phone),
            SizedBox(height: 5),
            AddressItem(
                label: AppLocalizations.of(context)!.address, value: address),
            SizedBox(height: 5),
            AddressItem(
                label: AppLocalizations.of(context)!.houseno, value: houseNo),
            SizedBox(height: 5),
            AddressItem(label: AppLocalizations.of(context)!.city, value: city),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: CustomButton(
          height: 52,
          width: 327,
          buttonText: AppLocalizations.of(context)!.checkoutnow,
          textSize: 14,
          backgroundColor: kTertiaryColor,
          onTap: () async {
            SendNotificationService.sendNotificationUsingApi(
                token:
                    'eFQgM-wDTVOmV702mzBMrc:APA91bFBjug6lis9X7yU-eZAWMv0XhoZ8l3CXdlDxhCeEyOL6Mo0qjt1aQHbB7NeG_AaQ--75mnL49SoRvRYJfISzujGaad2U3ipwz6LDNmt5cWudqvhcA8',
                title: 'check out',
                body: 'your order is on the way wait for few minutes',
                data: {"screen": "notification"});
            await _storePaymentDataToFirestore();
            await _storeNotificationDataToFirestore();
            Get.snackbar(
                "Success", "Payment data has been saved successfully!");
            Get.offAll(() => CartScreen());
          },
        ),
      ),
    );
  }

  Widget buildCartItem(CartItemModel item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CommonImageView(
              imagePath: item.imagePath,
              width: 80,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: item.name,
                  size: 16,
                  weight: FontWeight.w600,
                  color: kBlackyColor,
                ),
                SizedBox(height: 8),
                CustomText(
                  text: 'Quantity: ${item.quantity}',
                  size: 14,
                  weight: FontWeight.w500,
                  color: kgreyblackColor,
                ),
                SizedBox(height: 8),
                CustomText(
                  text: "\$ ${(item.price * item.quantity).toStringAsFixed(2)}",
                  size: 14,
                  weight: FontWeight.w700,
                  color: kTertiaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Transaction details now correctly account for quantity
  Widget buildTransactionDetails() {
    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Column(
      children: [
        DetailItem(
            name: "Total Items", price: "\$ ${totalPrice.toStringAsFixed(2)}"),
        SizedBox(height: 5),
        DetailItem(name: "Tax 10", price: "\$ 10.00"),
        SizedBox(height: 5),
        DetailItem(
            name: "Total Price",
            price: "\$ ${(totalPrice + 10.00).toStringAsFixed(2)}",
            highlight: true),
      ],
    );
  }

  Future<void> _storePaymentDataToFirestore() async {
    CollectionReference payments =
        FirebaseFirestore.instance.collection('orders');

    try {
      await payments.add({
        'cartItems': cartItems.map((item) {
          return {
            'name': item.name,
            'quantity': item.quantity, // Added quantity to be stored
            'price': item.price,
            'imagePath': item.imagePath,
          };
        }).toList(),
        'totalPrice': cartItems.fold(
                0, (sum, item) => sum + (item.price * item.quantity)) +
            10.00,
        'name': name,
        'phone': phone,
        'address': address,
        'houseNo': houseNo,
        'city': city,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to save payment data: $e");
    }
  }

  Future<void> _storeNotificationDataToFirestore() async {
    NotificationServices notificationServices = NotificationServices();

    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Notification data to be stored
    Map<String, dynamic> notificationData = {
      'title': 'Payment Successful',
      'message':
          'Your payment of \$${(cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity)) + 10.00).toStringAsFixed(2)} has been processed successfully.',
      'createdAt': FieldValue.serverTimestamp(),
      'fullPrice':
          cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity)) +
              10.00,
      'isProduct': cartItems.map((item) {
        return {
          'productName': item.name,
        };
      }).toList(),
    };
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(uid)
        .collection('notifications')
        .add(notificationData);
  }
}
