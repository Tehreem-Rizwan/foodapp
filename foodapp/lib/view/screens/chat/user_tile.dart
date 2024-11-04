import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: klightgreyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: Row(
            children: [Icon(Icons.person), Text(text)],
          ),
        ));
  }
}
