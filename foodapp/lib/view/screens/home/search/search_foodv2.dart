import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/custom_category_list_home.dart';
import 'package:foodapp/view/widget/custom_food_search_bar.dart';
import 'package:foodapp/view/widget/custom_recent_orders_list.dart';
import 'package:foodapp/view/widget/custom_recent_searches.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchFoodScreen extends StatefulWidget {
  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final TextEditingController _searchfoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String selectedCategory = AppLocalizations.of(context)!.burger;
    final List<Map<String, String>> categories = [
      {
        "name": AppLocalizations.of(context)!.burger,
        "assetPath": Assets.imagesBurgercategory
      },
      {
        "name": AppLocalizations.of(context)!.taco,
        "assetPath": Assets.imagesTacoscategory
      },
      {
        "name": AppLocalizations.of(context)!.drink,
        "assetPath": Assets.imagesDrinkcategory
      },
      {
        "name": AppLocalizations.of(context)!.pizza,
        "assetPath": Assets.imagesPizzacategory
      },
    ];
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0,
        leading: Padding(
          padding: only(context, left: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kWhite12Color),
            ),
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
                size: 16,
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
        title: CustomText(
          text: AppLocalizations.of(context)!.searchfood,
          color: kBlackyColor,
          size: 16,
          fontFamily: AppFonts.Inter,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: symmetric(context, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(context, 16)),
              CustomFoodSearchBar(
                height: h(context, 51),
                hintText: AppLocalizations.of(context)!.searchfood,
                Foodcontroller: _searchfoodController,
              ),
              SizedBox(height: h(context, 16)),
              CategoryList(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              SizedBox(height: h(context, 20)),
              RecentSearches(),
              SizedBox(height: h(context, 20)),
              Divider(
                color: kWhite12Color,
              ),
              SizedBox(height: h(context, 20)),
              CustomText(
                text: AppLocalizations.of(context)!.myrecentorder,
                size: 16,
                weight: FontWeight.w600,
                color: kBlackyColor,
              ),
              SizedBox(height: h(context, 20)),
              RecentOrdersList(),
            ],
          ),
        ),
      ),
    );
  }
}
