import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: AppLocalizations.of(context)!.recentsearches,
              size: 16,
              weight: FontWeight.w600,
              color: kBlackyColor,
            ),
            CustomText(
              text: AppLocalizations.of(context)!.beefBurger,
              size: 14,
              weight: FontWeight.w500,
              color: kTertiaryColor,
            ),
          ],
        ),
        SizedBox(height: h(context, 12)),
        SearchItem(
            label: AppLocalizations.of(context)!.burgers,
            iconPath: Assets.imagesSearch),
        SizedBox(height: h(context, 8)),
        SearchItem(
            label: AppLocalizations.of(context)!.fastfood,
            iconPath: Assets.imagesSearch),
        SearchItem(
            label: AppLocalizations.of(context)!.dessert,
            iconPath: Assets.imagesSearch),
        SizedBox(height: h(context, 8)),
        SearchItem(
            label: AppLocalizations.of(context)!.french,
            iconPath: Assets.imagesSearch),
        SizedBox(height: h(context, 8)),
        SearchItem(
            label: AppLocalizations.of(context)!.fastry,
            iconPath: Assets.imagesSearch),
      ],
    );
  }
}

class SearchItem extends StatelessWidget {
  final String label;
  final String iconPath;

  const SearchItem({
    Key? key,
    required this.label,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: kgreyblackColor,
              ),
              SizedBox(width: w(context, 20)),
              CustomText(
                text: label,
                size: 16,
                weight: FontWeight.w400,
                color: kBlackyColor,
              ),
            ],
          ),
          Icon(Icons.close, color: kgreyblackColor, size: 20),
        ],
      ),
    );
  }
}
