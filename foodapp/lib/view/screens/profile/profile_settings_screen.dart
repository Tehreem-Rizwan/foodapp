import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/profile/sign_out_dialogue.dart';
import 'package:foodapp/view/screens/services/auth_services.dart';
import 'package:foodapp/view/widget/Custom_button_widget.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_menu_section_widget.dart';
import 'package:foodapp/view/widget/custom_my_orders_widget.dart';
import 'package:foodapp/view/widget/custom_profile_info_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSettingsScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  // Fetching user profile data from Firestore
  Future<Map<String, dynamic>?> _getUserProfileData() async {
    final user =
        _authService.getCurrentUser(); // Use AuthService to get current user
    if (user != null) {
      final profileSnapshot = await FirebaseFirestore.instance
          .collection(
              'users') // Collection name must match your Firestore collection
          .doc(user.uid)
          .get();
      return profileSnapshot.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0,
        title: CustomText(
          text: AppLocalizations.of(context)!.profileSettings,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _getUserProfileData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading profile data.'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No profile data available.'));
          }

          final profileData = snapshot.data!;
          final profileImageUrl =
              profileData['imageUrl'] ?? Assets.imagesProfilepicture;
          final userName = profileData['fullname'] ?? 'Unknown Name';
          final userEmail = profileData['email'] ?? 'Unknown Email';
          final orders = profileData['orders'] ??
              []; // Assuming orders data is stored in profile

          return SingleChildScrollView(
            child: Padding(
              padding: symmetric(context, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h(context, 20)),
                  // Profile Information Widget
                  ProfileInfo(
                    profileImagePath: profileImageUrl,
                    userName: userName,
                    userEmail: userEmail,
                    cameraImagePath: Assets.imagesCamera,
                  ),

                  // Displaying Orders (Assuming orders are stored in the profile)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return MyOrders(
                        orderId: order['orderId'] ?? 'No ID',
                        itemName: order['itemName'] ?? 'Unknown Item',
                        itemPrice: '\$${order['itemPrice'] ?? '0.00'}',
                        itemCount: '${order['itemCount']} items',
                        onSeeAll: () {
                          // ); // Replace with your orders page
                        },
                      );
                    },
                  ),

                  MenuSection(),

                  // Sign Out Button
                  Padding(
                    padding: symmetric(context, vertical: 16),
                    child: Center(
                      child: GestureDetector(
                        child: CustomButton3(
                          height: 52,
                          width: w(context, 327),
                          onTap: () {
                            SignOutDialog.show(context); // Show sign-out dialog
                          },
                          buttonText: '',
                          textColor: kRedColor,
                          textSize: 14,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonImageView(
                                imagePath: Assets.imagesSignout,
                                height: 13,
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: w(context, 10)),
                              CustomText(
                                  text: AppLocalizations.of(context)!.signOut,
                                  size: 14,
                                  color: kRedColor,
                                  weight: FontWeight.bold),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h(context, 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
