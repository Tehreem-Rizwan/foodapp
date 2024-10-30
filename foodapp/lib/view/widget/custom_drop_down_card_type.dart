import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class CustomDropdownField extends StatefulWidget {
  final String text;
  final String hinttext;
  final List<String> items;

  const CustomDropdownField({
    Key? key,
    required this.text,
    required this.hinttext,
    required this.items,
  }) : super(key: key);

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.text,
          size: 14,
          weight: FontWeight.bold,
          color: kBlackyColor,
        ),
        SizedBox(height: h(context, 8)),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(h(context, 8)),
            border: Border.all(color: kWhite12Color),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              hint: CustomText(
                text: widget.hinttext,
                size: 14,
                weight: FontWeight.w500,
                color: kgreyblackColor,
              ),
              icon: Icon(Icons.arrow_drop_down, color: kgreyblackColor),
              items: widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(
                    text: value,
                    size: 14,
                    weight: FontWeight.w500,
                    color: kBlackyColor,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
