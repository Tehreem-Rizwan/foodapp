import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/home/home.dart';
import 'package:foodapp/view/screens/launch/auth/forgot_password_selection.dart';
import 'package:foodapp/view/screens/launch/auth/registration_Screen.dart';
import 'package:foodapp/view/widget/Custom_Textfield_widget.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_social_button_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninScreen extends StatefulWidget {
  final String userEmail;

  SigninScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool emailError = false;
  bool passwordError = false;
  String errorMessage = '';
  String emailErrorText = '';
  String passwordErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: symmetric(
          context,
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(context, 70)),
              CustomText(
                text: AppLocalizations.of(context)!.logintoyouraccount,
                size: 32,
                weight: FontWeight.w600,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomText(
                text: AppLocalizations.of(context)!.pleasesignintoyouraccount,
                size: 14,
                weight: FontWeight.w500,
                color: kgreyblackColor,
              ),
              SizedBox(height: h(context, 28)),
              CustomText(
                text: AppLocalizations.of(context)!.emailaddress,
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomTextField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.enterEmail,
                hasError: emailError,
                errorText: emailError ? emailErrorText : null,
              ),
              if (emailError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomText(
                    text: 'Email not found or incorrect',
                    size: 12,
                    color: Colors.red,
                  ),
                ),
              SizedBox(height: h(context, 25)),
              CustomText(
                text: AppLocalizations.of(context)!.password,
                size: 14,
                weight: FontWeight.w700,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 8)),
              CustomTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.password,
                isIcon: true,
                obscureText: true,
                hasError: passwordError,
                errorText: passwordError ? passwordErrorText : null,
              ),
              if (passwordError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomText(
                    text: 'Password is incorrect',
                    size: 12,
                    color: Colors.red,
                  ),
                ),
              SizedBox(height: h(context, 16)),
              GestureDetector(
                onTap: () {
                  // Use widget.userEmail instead of userEmail
                  if (widget.userEmail.isNotEmpty) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: double.infinity,
                          height: h(context, 420), // Adjust height as needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(h(context, 28)),
                              topRight: Radius.circular(h(context, 28)),
                            ),
                            color: kSecondaryColor,
                          ),
                          child: ForgotPasswordSelection(
                              userEmail: widget.userEmail), // Correct usage
                        );
                      },
                    );
                  } else {
                    // Handle the case where userEmail is null or empty
                    print("No user email available.");
                  }
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    text: AppLocalizations.of(context)!.forgotpassword,
                    fontFamily: AppFonts.Inter,
                    size: 14,
                    weight: FontWeight.w500,
                    color: kTertiaryColor,
                  ),
                ),
              ),
              SizedBox(height: h(context, 28)),
              Center(
                child: CustomButton(
                    height: 52,
                    width: w(context, 327),
                    buttonText: AppLocalizations.of(context)!.signin,
                    textSize: 14,
                    backgroundColor: kTertiaryColor,
                    onTap: () async {
                      emailError = false;
                      passwordError = false;

                      if (emailController.text.isEmpty) {
                        setState(() {
                          emailError = true;
                          emailErrorText = "Please enter an email address.";
                        });
                      } else if (passwordController.text.isEmpty) {
                        setState(() {
                          passwordError = true;
                          passwordErrorText = "Please enter your password.";
                        });
                      } else {
                        try {
                          UserCredential userCredential =
                              await _auth.signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          User? user = userCredential.user;
                          if (user != null) {
                            await _firestore
                                .collection('users')
                                .doc(user.uid)
                                .set({
                              'email': user.email,
                              'uid': user.uid,
                              'createdAt': FieldValue.serverTimestamp(),
                            }, SetOptions(merge: true));

                            Get.to(() => HomePage());
                          }
                        } catch (e) {
                          setState(() {
                            emailError = true;
                            emailErrorText = "";
                            passwordError =
                                true; // Only set password error if appropriate
                          });
                        }
                      }
                    }),
              ),
              SizedBox(height: h(context, 18)),
              Row(
                children: [
                  Expanded(child: Divider(color: kgreyblackColor)),
                  Padding(
                    padding: symmetric(context, horizontal: 8),
                    child: CustomText(
                      text: AppLocalizations.of(context)!.orsigninwith,
                      fontFamily: AppFonts.Inter,
                      size: 14,
                      weight: FontWeight.w500,
                      color: kgreyblackColor,
                    ),
                  ),
                  Expanded(child: Divider(color: kgreyblackColor)),
                ],
              ),
              SizedBox(height: h(context, 20)),
              Row(
                children: [
                  SizedBox(width: w(context, 90)),
                  SocialButton(
                    asset: Assets.imagesGoogle,
                    onTap: () async {
                      //  try {
                      //   final GoogleSignInAccount? googleUser =
                      //       await GoogleSignIn().signIn();
                      //   if (googleUser != null) {
                      //     final GoogleSignInAuthentication googleAuth =
                      //         await googleUser.authentication;
                      //     final AuthCredential credential =
                      //         GoogleAuthProvider.credential(
                      //       accessToken: googleAuth.accessToken,
                      //       idToken: googleAuth.idToken,
                      //     );
                      //     await _auth.signInWithCredential(credential);
                      //     Get.to(() => HomePage());
                      //   }
                      // } catch (e) {
                      //   Get.snackbar("Error", "Google sign-in failed",
                      //       backgroundColor: kRedColor);
                      // }
                    },
                  ),
                  SizedBox(width: w(context, 20)),
                  SocialButton(
                    asset: Assets.imagesFacebook,
                    onTap: () async {},
                  ),
                  SizedBox(width: w(context, 20)),
                  SocialButton(
                    asset: Assets.imagesApple,
                    onTap: () async {},
                  ),
                ],
              ),
              SizedBox(height: h(context, 30)),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.donthaveanaccount,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kBlackyColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.register,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kTertiaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => RegistrationScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
