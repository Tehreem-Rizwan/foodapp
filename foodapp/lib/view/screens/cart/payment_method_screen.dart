import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/controllers/payment_method_controller.dart';
import 'package:foodapp/view/screens/cart/cart_item_model.dart';
import 'package:foodapp/view/screens/cart/easy_paisa_page.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_payment_option_tile.dart';
import 'package:get/get.dart';
import 'package:foodapp/view/screens/cart/jazzcash.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double finalTotal;
  final List<CartItemModel> cartItems;

  PaymentMethodScreen({required this.cartItems, required this.finalTotal});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final PaymentMethodController controller = Get.put(PaymentMethodController());

  // Text controllers for user inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _houseNoController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Payment Method",
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffF2F2F2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => OptionTile(
                  isSelected: controller.selectedMethod.value == 'Easypaisa',
                  text: 'Easypaisa \n03372873909',
                  assetPath: Assets.imagesEasypaisa,
                  onTap: () {
                    controller.selectMethod('Easypaisa');
                  },
                )),
            const SizedBox(height: 10),
            Obx(() => OptionTile(
                  isSelected: controller.selectedMethod.value == 'Jazzcash',
                  text: 'Jazzcash \n03372873909',
                  assetPath: Assets.imagesJazzcash,
                  onTap: () {
                    controller.selectMethod('Jazzcash');
                  },
                )),
            const SizedBox(height: 52),
            Center(
              child: CustomButton(
                width: 334,
                textSize: 16,
                onTap: () {
                  if (controller.selectedMethod.value == 'Jazzcash') {
                    Get.to(() => JazzCash());
                  } else if (controller.selectedMethod.value == 'Easypaisa') {
                    Get.to(() => EasypaisaScreen());
                  } else {
                    print('Error: No payment method selected');
                  }
                },
                buttonText: "PROCEED TO PAY",
                backgroundColor: kTertiaryColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                textColor: kSecondaryColor,
                height: 52,
              ),
            )
          ],
        ),
      ),
    );
  }

  double _calculateTotal(List<CartItemModel> cartItems) {
    return cartItems.fold(
            0, (sum, item) => sum + (item.price * item.quantity)) +
        10.0;
  }
}
