import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_Textfield_widget.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_gender_drop_down_list.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDataPage extends StatefulWidget {
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      print('Camera permission denied');
    }
  }

  Future<void> _saveData() async {
    String? imageUrl;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Update profile picture if a new image is selected
      if (_image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${user.uid}');
        final uploadTask = storageRef.putFile(_image!);
        await uploadTask.whenComplete(() async {
          imageUrl = await storageRef.getDownloadURL();
        });
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullname': fullnameController.text,
        'dob': dobController.text,
        'email': emailController.text,
        'phone': phonenumberController.text,
        'imageUrl': imageUrl ?? '',
      }, SetOptions(merge: true));

      if (user.email != emailController.text) {
        try {
          await user.updateEmail(emailController.text);
          await user.reload();
          user = FirebaseAuth.instance.currentUser; // Reload the user
        } catch (error) {
          print("Error updating email: $error");
        }
      }

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.back(); // Return to the previous screen
    } else {
      print("User not logged in. Cannot save profile data.");
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
                Get.back(); // Navigate back
              },
            ),
          ),
        ),
        title: CustomText(
          text: AppLocalizations.of(context)!.personalData,
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
            SizedBox(height: h(context, 10)),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Choose an option'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text('Camera'),
                            onTap: () {
                              _pickImage(ImageSource.camera); // Open camera
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text('Gallery'),
                            onTap: () {
                              _pickImage(ImageSource.gallery); // Open gallery
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: w(context, 100),
                height: h(context, 100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.contain,
                        )
                      : DecorationImage(
                          image: AssetImage(
                              Assets.imagesProfilepicture), // Default image
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: AppLocalizations.of(context)!.fullname,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: fullnameController,
              hintText: AppLocalizations.of(context)!.enterfullname,
            ),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: AppLocalizations.of(context)!.dateofbirth,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: dobController,
              hintText: AppLocalizations.of(context)!.enterdateofbirth,
            ),
            SizedBox(height: h(context, 20)),
            GenderDropdownField(),
            SizedBox(height: h(context, 20)),
            CustomText(
              text: AppLocalizations.of(context)!.phone,
              size: 14,
              weight: FontWeight.w700,
              color: kBlackyColor,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField(
              controller: phonenumberController,
              hintText: AppLocalizations.of(context)!.enterphoneno,
            ),
            SizedBox(height: h(context, 20)),
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
            ),
            SizedBox(height: h(context, 45)),
            Center(
              child: CustomButton(
                height: 52,
                width: w(context, 327),
                buttonText: AppLocalizations.of(context)!.save,
                textSize: 14,
                backgroundColor: kTertiaryColor,
                onTap: _saveData, // Call the save function
              ),
            ),
            SizedBox(height: h(context, 45)),
          ],
        ),
      ),
    );
  }
}
