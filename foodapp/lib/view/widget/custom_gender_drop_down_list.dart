import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class GenderDropdownField extends StatefulWidget {
  @override
  _GenderDropdownFieldState createState() => _GenderDropdownFieldState();
}

class _GenderDropdownFieldState extends State<GenderDropdownField> {
  late String? selectedGender = AppLocalizations.of(context)!.male;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppLocalizations.of(context)!.gender,
          size: 14,
          weight: FontWeight.bold,
          color: kBlackyColor,
        ),
        SizedBox(height: h(context, 8)),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kSecondaryColor,
            border: Border.all(color: kWhite12Color),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGender,
              icon:
                  Image.asset(Assets.imagesDropdownmenu, width: 20, height: 20),
              isExpanded: true,
              items: [
                AppLocalizations.of(context)!.male,
                AppLocalizations.of(context)!.female
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(
                    text: value,
                    size: 14,
                    color: kBlackyColor,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
