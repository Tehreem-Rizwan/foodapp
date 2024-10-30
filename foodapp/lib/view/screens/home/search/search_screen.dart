import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_search_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: symmetric(
          context,
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(context, 70)),
              CustomText(
                text: AppLocalizations.of(context)!.findYourFavoriteFood,
                size: 32,
                weight: FontWeight.w600,
                color: kBlackyColor,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: h(context, 20)),
              CustomSearchBar(
                width: 400,
                height: 52,
                hintText: AppLocalizations.of(context)!.searchSomething,
                controller: _searchController,
              ),
              SizedBox(height: h(context, 25)),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonImageView(
                      imagePath: Assets.imagesSearchIllustration,
                      height: 128,
                      width: 172,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: h(context, 8)),
                    CustomText(
                      text:
                          AppLocalizations.of(context)!.wecouldntfindanyresults,
                      size: 16,
                      weight: FontWeight.w600,
                      color: kBlackyColor,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h(context, 8)), // Adjust spacing
                    CustomText(
                      text: AppLocalizations.of(context)!
                          .pleasecheckyoursearchforanytyposorspellingerrorsortryadifferentsearchterm,
                      size: 14,
                      weight: FontWeight.w500,
                      color: kgreyblackColor,
                      textAlign: TextAlign.center,
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
}
