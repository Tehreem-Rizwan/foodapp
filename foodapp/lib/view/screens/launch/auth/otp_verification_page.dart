import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/controllers/otp_controller.dart';
import 'package:foodapp/view/screens/launch/auth/reset_password.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_otp_input_field.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpVerificationPage extends StatelessWidget {
  final String otp;
  final String email;

  OtpVerificationPage({required this.otp, required this.email});

  final TextEditingController otp1Controller = TextEditingController();
  final TextEditingController otp2Controller = TextEditingController();
  final TextEditingController otp3Controller = TextEditingController();
  final TextEditingController otp4Controller = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final OtpController otpController =
      Get.put(OtpController(otp: '', email: ''));
  void _sendOtp() async {
    String email = _emailController.text;

    String otp = (1000 + Random().nextInt(9000)).toString();

    await _sendOtpToEmail(email, otp);
  }

  Future<void> _sendOtpToEmail(String email, String otp) async {
    print("Sending OTP: $otp to email: $email");
  }

  String _generateNewOtp() {
    return (1000 +
            (9999 - 1000) *
                (new DateTime.now().millisecondsSinceEpoch % 1e6) ~/
                1e6)
        .toString();
  }

  void _verifyOtp() {
    String userOtp = otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text;

    if (userOtp == otp) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text('OTP Verified!')));
      Get.to(() => ResetPasswordPage(email: email));
    } else {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text('Invalid OTP.')));
    }
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
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
          text: AppLocalizations.of(context)!.otp,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h(context, 27)),
            CustomText(
              text: AppLocalizations.of(context)!.emailverification,
              size: 32,
              weight: FontWeight.w600,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomText(
              text: AppLocalizations.of(context)!
                  .entertheverificationcodewesentyouonAlbertsgmailcom,
              size: 14,
              weight: FontWeight.w500,
              color: kgreyblackColor,
              fontFamily: AppFonts.Inter,
            ),
            SizedBox(height: h(context, 48)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtpInputField(controller: otp1Controller),
                OtpInputField(controller: otp2Controller),
                OtpInputField(controller: otp3Controller),
                OtpInputField(controller: otp4Controller),
              ],
            ),
            SizedBox(height: h(context, 16)),
            Row(
              children: [
                Center(
                  child: CustomText(
                    text: AppLocalizations.of(context)!.didntreceivecode,
                    size: 14,
                    weight: FontWeight.w500,
                    fontFamily: AppFonts.Inter,
                    color: kgreyblackColor,
                  ),
                ),
                SizedBox(width: w(context, 8)),
                GestureDetector(
                  onTap: () {
                    _sendOtpToEmail(email, otp);
                  },
                  child: CustomText(
                    text: AppLocalizations.of(context)!.resend,
                    size: 14,
                    weight: FontWeight.w700,
                    fontFamily: AppFonts.Inter,
                    color: kTertiaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: h(context, 35)),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time, color: kgreyblackColor),
                  SizedBox(width: w(context, 8)),
                  Obx(() {
                    return CustomText(
                      text:
                          '00:${otpController.start.toString().padLeft(2, '0')}', // Observe the countdown value
                      size: 14,
                      weight: FontWeight.w500,
                      fontFamily: AppFonts.Inter,
                      color: kgreyblackColor,
                    );
                  }),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
                height: 52,
                width: w(context, 327),
                buttonText: AppLocalizations.of(context)!.continuee,
                textSize: 14,
                backgroundColor: kTertiaryColor,
                onTap: _verifyOtp),
            SizedBox(height: h(context, 24)),
          ],
        ),
      ),
    );
  }
}
