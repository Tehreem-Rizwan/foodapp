import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_Textfield_widget.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:get/get.dart';
import 'otp_verification_page.dart';

class SendCodePhoneno extends StatefulWidget {
  @override
  _SendCodePhonenoState createState() => _SendCodePhonenoState();
}

class _SendCodePhonenoState extends State<SendCodePhoneno> {
  final TextEditingController _phoneController = TextEditingController();
  String _verificationId = "";

  void _sendOtp() async {
    String phoneNumber = _phoneController.text;

    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid phone number")),
      );
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+1$phoneNumber", // Adjust for your country code
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-verification callback
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Verification failed")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
        Get.to(() => OtpVerificationPage(
              verificationId: _verificationId,
              phoneNumber: phoneNumber,
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: symmetric(context, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h(context, 60)),
            CustomText(
              text: "Forgot Password",
              size: 32,
              weight: FontWeight.w700,
              color: kBlackyColor,
              fontFamily: AppFonts.Inter,
            ),
            SizedBox(height: h(context, 8)),
            CustomText(
              text: "Enter your phone number to receive an OTP",
              size: 14,
              weight: FontWeight.w600,
              fontFamily: AppFonts.Inter,
              color: kgreyblackColor,
            ),
            SizedBox(height: h(context, 40)),
            CustomTextField2(
              controller: _phoneController,
              hintText: "Enter phone number",
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomButton(
          height: 52,
          buttonText: "Send OTP",
          onTap: _sendOtp,
          width: w(context, 327),
          textSize: 14,
        ),
      ),
    );
  }
}
