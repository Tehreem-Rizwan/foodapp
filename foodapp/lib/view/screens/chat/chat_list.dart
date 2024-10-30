import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/view/screens/chat/chat.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_chat_item_chat_list_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 60,
            title: Row(
              children: [
                CustomText(
                  fontFamily: AppFonts.Inter,
                  text: AppLocalizations.of(context)!.chatlist,
                  size: 16,
                  weight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kTransparentColor,
            pinned: true,
            centerTitle: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: CommonImageView(
                imagePath: Assets.imagesPattern,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    fontFamily: AppFonts.Inter,
                    text: AppLocalizations.of(context)!.allmessages,
                    size: 16,
                    weight: FontWeight.w600,
                    color: kBlackyColor,
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ChatScreen(contactName: 'User $index'));
                        },
                        child: ChatItemWidget(
                          imagePath: index.isEven
                              ? Assets.imagesGeopartEtdsien
                              : Assets
                                  .imagesStevanoClirover, // Alternating images for variety
                          name: 'User $index', // Example user name
                          message: 'Your order just arrived',
                          time: '11:23',
                          showBadge: index % 2 ==
                              0, // Show badge on alternate messages
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
