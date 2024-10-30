import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationWidget extends StatelessWidget {
  final String selectedLocation;
  final Function onCountrySelected;

  const LocationWidget({
    Key? key,
    required this.selectedLocation,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              text: AppLocalizations.of(context)!.yourLocation,
              size: 14,
              weight: FontWeight.w400,
              color: kSecondaryColor,
            ),
            SizedBox(
              width: w(context, 10),
            ),
            GestureDetector(
              onTap: () => onCountrySelected(),
              child: Image(
                image: AssetImage(Assets.imagesDropdownicon),
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: h(context, 10),
        ),
        Row(
          children: [
            Image(
              image: AssetImage(Assets.imagesLocation),
              color: kSecondaryColor,
            ),
            SizedBox(
              width: w(context, 4),
            ),
            CustomText(
              text: selectedLocation,
              size: 14,
              weight: FontWeight.w600,
              color: kSecondaryColor,
            ),
          ],
        ),
        SizedBox(width: w(context, 5)),
      ],
    );
  }
}
