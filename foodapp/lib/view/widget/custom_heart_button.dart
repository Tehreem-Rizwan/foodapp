import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';

class HeartButton extends StatefulWidget {
  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool isFavorite = false; // Track the favorite state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kWhite12Color),
        ),
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: kSecondaryColor,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite; // Toggle favorite state
            });
          },
        ),
      ),
    );
  }
}
