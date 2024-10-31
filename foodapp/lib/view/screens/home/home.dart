import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/cart/order_empty.dart';
import 'package:foodapp/view/screens/chat/chat_list.dart';
import 'package:foodapp/view/screens/nav_bar/bottom_nav_bar.dart';
import 'package:foodapp/view/screens/home/search/search_foodv2.dart';
import 'package:foodapp/view/screens/home/search/search_screen.dart';
import 'package:foodapp/view/screens/profile/profile_settings_screen.dart';
import 'package:foodapp/view/screens/home/notification.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_category_list_home.dart';
import 'package:foodapp/view/widget/custom_food_card_home_widget.dart';
import 'package:foodapp/view/widget/custom_icon_button_home.dart';
import 'package:foodapp/view/widget/custom_location_widget_home.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeController extends GetxController {
  var selectedLocation = "New York City".obs;
  var selectedCategory = "Burger".obs;
  var selectedNavBarIndex = 0.obs;

  final List<String> countries = [
    "New York City",
    "Los Angeles",
    "Chicago",
    "San Francisco"
  ];

  void changeNavBarIndex(int index) {
    selectedNavBarIndex.value = index;
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
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

    final List<Map<String, dynamic>> foodItems = [
      {
        "image": Assets.imagesOrdinaryburger,
        "title": AppLocalizations.of(context)!.ordinaryburger,
        "price": "\$17,230"
      },
      {
        "image": Assets.imagesBurgerwithmeat,
        "title": AppLocalizations.of(context)!.burgerWithMeat,
        "price": "\$17,230"
      },
      {
        "image": Assets.imagesBurgerwithbeef,
        "title": AppLocalizations.of(context)!.beefBurger,
        "price": "\$17,230"
      },
      {
        "image": Assets.imagesBurgerwithfries,
        "title": AppLocalizations.of(context)!.burgerwithfries,
        "price": "\$17,230"
      },
    ];

    return Scaffold(
      body: Obx(() {
        return homeController.selectedNavBarIndex.value == 0
            ? HomeContent(context, foodItems, categories)
            : SelectedPage(homeController.selectedNavBarIndex.value);
      }),
      bottomNavigationBar: Obx(() {
        return CustomBottomNavBar(
          selectedNavBarIndex: homeController.selectedNavBarIndex.value,
          onTap: (index) {
            homeController.changeNavBarIndex(index);
          },
        );
      }),
    );
  }

  Widget SelectedPage(int index) {
    final List<Widget> pages = [
      EmptyCartScreen(),
      ProviderScope(child: ChatListPage()),
      ProfileSettingsScreen(),
    ];
    return pages[index - 1];
  }

  Widget HomeContent(BuildContext context, List<Map<String, dynamic>> foodItems,
      List<Map<String, String>> categories) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: h(context, 90),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return LocationWidget(
                  selectedLocation: homeController.selectedLocation.value,
                  onCountrySelected: () {},
                );
              }),
              Spacer(),
              InkWell(
                  onTap: () {
                    Get.to(() => SearchScreen());
                  },
                  child: IconButtonWidget(assetPath: Assets.imagesSearch)),
              SizedBox(width: w(context, 14)),
              GestureDetector(
                onTap: () {
                  Get.to(() => NotificationScreen());
                },
                child: IconButtonWidget(assetPath: Assets.imagesNotification),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: kTransparentColor,
          pinned: true,
          expandedHeight: h(context, 353),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                CommonImageView(
                  imagePath: Assets.imagesHomebanner,
                  width: double.maxFinite,
                  height: 346,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: h(context, 55),
                  left: w(context, 20),
                  child: CustomText(
                    text:
                        AppLocalizations.of(context)!.providethebestfoodforyou,
                    size: 32,
                    weight: FontWeight.w600,
                    color: kSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.findbyCategory,
                      size: 16,
                      weight: FontWeight.w600,
                      color: kBlackyColor,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SearchFoodScreen());
                      },
                      child: CustomText(
                        text: AppLocalizations.of(context)!.seeall,
                        size: 14,
                        weight: FontWeight.w500,
                        color: kTertiaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h(context, 20)),
              Obx(() {
                return CategoryList(
                  categories: categories, // Use the categories defined in build
                  selectedCategory: homeController.selectedCategory.value,
                  onCategorySelected: (category) {
                    homeController.changeCategory(category);
                  },
                );
              }),
              SizedBox(height: h(context, 20)),
              FoodCardList(context, foodItems),
              SizedBox(height: h(context, 40)),
            ],
          ),
        ),
      ],
    );
  }

  Widget FoodCardList(
      BuildContext context, List<Map<String, dynamic>> foodItems) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return FoodCard(foodItem: foodItems[index]);
        },
      ),
    );
  }
}
