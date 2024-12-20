import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/launch/auth/forgot_password_screen.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_contact_details_forgot_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordSelection extends StatefulWidget {
  final String userEmail;

  const ForgotPasswordSelection({Key? key, required this.userEmail})
      : super(key: key);

  @override
  _ForgotPasswordSelectionState createState() =>
      _ForgotPasswordSelectionState();
}

class _ForgotPasswordSelectionState extends State<ForgotPasswordSelection> {
  String? selectedOption = 'Send via SMS';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h(context, 16)),
            CustomText(
              text: AppLocalizations.of(context)!.forgotpassword,
              size: 24,
              weight: FontWeight.w800,
              color: kBlackyColor,
              fontFamily: AppFonts.Inter,
            ),
            SizedBox(height: h(context, 12)),
            CustomText(
              text: AppLocalizations.of(context)!
                  .selectwhichcontactdetailsshouldweusetoresetyourpassword,
              size: 14,
              weight: FontWeight.w500,
              color: kgreyblackColor,
              fontFamily: AppFonts.Inter,
            ),
            SizedBox(height: h(context, 24)),
            OptionWidget(
              iconPath: Assets.imagesWhatsapp,
              title: AppLocalizations.of(context)!.sendviaWhatsApp,
              subtitle: '',
              selected:
                  selectedOption == AppLocalizations.of(context)!.whatsApp,
              onTap: () {
                setState(() {
                  selectedOption = AppLocalizations.of(context)!.whatsApp;
                });
              },
            ),
            OptionWidget(
              iconPath: Assets.imagesEmail,
              title: AppLocalizations.of(context)!.sendviaEmail,
              subtitle: widget.userEmail,
              selected: selectedOption == AppLocalizations.of(context)!.email,
              onTap: () {
                setState(() {
                  selectedOption = AppLocalizations.of(context)!.email;
                });
              },
            ),
            OptionWidget(
              iconPath: Assets.imagesWhatsapp,
              title: "Send Via SMS",
              subtitle: 'Your phone number',
              selected: selectedOption == 'Send via SMS',
              onTap: () {
                setState(() {
                  selectedOption = 'Send via SMS';
                });
              },
            ),
            SizedBox(height: h(context, 40)),
            Center(
              child: CustomButton(
                height: 52,
                width: w(context, 327),
                buttonText: AppLocalizations.of(context)!.continuee,
                textSize: 14,
                backgroundColor: kTertiaryColor,
                onTap: () {
                  if (selectedOption == 'Send via SMS') {
                    //  Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) => PhoneNumberScreen(), // Navigate to PhoneNumberScreen
                    // ),
                    //  );
                  } else if (selectedOption ==
                      AppLocalizations.of(context)!.email) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                      ),
                    );
                  } else {
                    print('Selected option: $selectedOption');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
