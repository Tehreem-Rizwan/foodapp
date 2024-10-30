import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String asset;

  SocialButton({required this.asset, required Future<Null> Function() onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: Colors.grey,
            width: 1), // Replace with your klightgreyColor if needed
      ),
      padding: EdgeInsets.all(8),
      child: Image.asset(
        asset,
        width: 24,
        height: 24,
      ),
    );
  }
}
