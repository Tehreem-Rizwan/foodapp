import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({Key? key}) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;
  void _increaseQuantity() {
    setState(() {
      quantity++; // Increment the quantity
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--; // Decrement the quantity if it's greater than 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _circleButton(context, Icons.remove, _decreaseQuantity),
        SizedBox(width: 16), // Assuming w(context, 16) returns 16 here
        Text(
          quantity.toString(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: f(context, 18),
            fontWeight: FontWeight.w600,
            color: kBlackyColor,
          ),
        ),
        SizedBox(width: 16),
        _circleButton(context, Icons.add, _increaseQuantity),
      ],
    );
  }

  Widget _circleButton(
      BuildContext context, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: w(context, 40),
        height: h(context, 40),
        decoration: BoxDecoration(
            border: Border.all(color: kWhite12Color),
            shape: BoxShape.circle,
            color: kSecondaryColor),
        child: Icon(icon, size: 20, color: kBlackyColor),
      ),
    );
  }
}
