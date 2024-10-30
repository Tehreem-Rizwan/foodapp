import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/cart/cart_item_model.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class CartItemWidget extends StatefulWidget {
  final CartItemModel cartItem;
  final VoidCallback onChanged;

  CartItemWidget({required this.cartItem, required this.onChanged});

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: h(context, 16)),
      child: Card(
        color: kSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(h(context, 12)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Checkbox(
                value: widget.cartItem.isChecked,
                onChanged: (value) {
                  setState(() {
                    widget.cartItem.isChecked = value!;
                  });
                  widget.onChanged(); // Notify parent about the change
                },
                checkColor: kSecondaryColor,
                activeColor: kTertiaryColor,
                side: BorderSide(color: kTertiaryColor),
              ),
              Container(
                width: w(context, 85),
                height: w(context, 82),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(h(context, 12)),
                  image: DecorationImage(
                    image: AssetImage(widget.cartItem.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: w(context, 16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.cartItem.name,
                      size: 16,
                      weight: FontWeight.w600,
                      color: kBlackyColor,
                    ),
                    CustomText(
                      text: '\$${widget.cartItem.price}',
                      size: 14,
                      weight: FontWeight.w700,
                      color: kTertiaryColor,
                    ),
                    SizedBox(height: h(context, 8)),
                    Row(
                      children: [
                        _buildQuantityButton(context, Icons.remove, () {
                          setState(() {
                            if (widget.cartItem.quantity > 1) {
                              widget.cartItem.quantity--;
                            }
                          });
                          widget.onChanged();
                        }),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: CustomText(
                            text: '${widget.cartItem.quantity}',
                            size: 14,
                            weight: FontWeight.w500,
                            color: kBlackyColor,
                          ),
                        ),
                        _buildQuantityButton(context, Icons.add, () {
                          setState(() {
                            widget.cartItem.quantity++;
                          });
                          widget.onChanged();
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton(
      BuildContext context, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFEDEDED)),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
