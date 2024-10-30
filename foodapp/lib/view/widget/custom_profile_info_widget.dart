import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class ProfileInfo extends StatelessWidget {
  final String profileImagePath;
  final String userName;
  final String userEmail;
  final String cameraImagePath; // Path for the camera icon image

  const ProfileInfo({
    Key? key,
    required this.profileImagePath,
    required this.userName,
    required this.userEmail,
    required this.cameraImagePath,
  }) : super(key: key);

  bool isNetworkImage(String path) {
    return path.startsWith('http') || path.startsWith('https');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: w(context, 100),
          height: h(context, 100),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              ClipOval(
                child: isNetworkImage(profileImagePath)
                    ? Image.network(
                        profileImagePath,
                        fit: BoxFit.cover,
                        width: w(context, 100),
                        height: h(context, 100),
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                              Icons.error); // Handle any error while loading
                        },
                      )
                    : Image.asset(
                        profileImagePath,
                        fit: BoxFit.cover,
                        width: w(context, 100),
                        height: h(context, 100),
                      ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: w(context, 32),
                  height: h(context, 32),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: klightbluecolor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor,
                      ),
                      child: Center(
                        child: Image.asset(
                          cameraImagePath,
                          fit: BoxFit.contain,
                          width: 16,
                          height: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: h(context, 16)),
        CustomText(
          text: userName,
          size: 16,
          weight: FontWeight.w600,
          color: kBlackyColor,
        ),
        CustomText(
          text: userEmail,
          size: 14,
          weight: FontWeight.w400,
          color: kgreyblackColor,
        ),
      ],
    );
  }
}
