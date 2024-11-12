import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/controllers/payment_method_controller.dart';
import 'package:foodapp/view/screens/cart/cart_item_model.dart';
import 'package:foodapp/view/screens/cart/easy_paisa_page.dart';
import 'package:foodapp/view/screens/cart/jazzcash.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_payment_option_tile.dart';
import 'package:get/get.dart';

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
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
              size: 16,
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
                  isSelected: controller.selectedMethod.value == 'JazzCash',
                  text: 'JazzCash \n03372873909',
                  assetPath: Assets.imagesJazzcash,
                  onTap: () {
                    controller.selectMethod('JazzCash');
                  },
                )),
            const SizedBox(height: 20),
            CustomButton(
              height: 52,
              width: double.infinity,
              buttonText: 'Proceed to Checkout',
              backgroundColor: kTertiaryColor,
              textSize: 14,
              onTap: () {
                if (controller.selectedMethod.value.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please select a payment method",
                    backgroundColor: kRedColor,
                    colorText: kSecondaryColor,
                  );
                  return;
                }
                // Navigate to the appropriate payment page
                if (controller.selectedMethod.value == 'Easypaisa') {
                  Get.to(() => EasypaisaScreen(
                        cartItems: widget.cartItems,
                        amount: widget.finalTotal
                            .toString(), // Pass the dynamic amount
                      ));
                } else if (controller.selectedMethod.value == 'JazzCash') {
                  Get.to(() => JazzCash());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
