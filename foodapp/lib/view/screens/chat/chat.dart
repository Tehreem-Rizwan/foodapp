import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/chat/call_screen.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_chat_input_widget.dart';
import 'package:foodapp/view/widget/custom_received_message_chat_widget.dart';
import 'package:foodapp/view/widget/custom_sent_message_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatelessWidget {
  final String contactName; // Add the contact name parameter
  final TextEditingController messageController = TextEditingController();

  ChatScreen({required this.contactName}); // Constructor accepts contactName

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: h(context, 70),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: only(context, top: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                CustomText(
                  fontFamily: AppFonts.Inter,
                  text: contactName,
                  size: 16,
                  weight: FontWeight.w600,
                  color: kBlackyColor,
                ),
                Padding(
                  padding: only(context, top: 8, left: 12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kWhite12Color),
                    ),
                    child: IconButton(
                      icon: InkWell(
                        onTap: () {
                          Get.to(() => CallScreen());
                        },
                        child: Image(
                          image: AssetImage(Assets.imagesCall),
                          color: kPrimaryColor,
                          height: 16,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kTransparentColor,
            pinned: true,
            expandedHeight: h(context, 100),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: CommonImageView(
                imagePath: Assets.imagesPattern,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CommonImageView(
                      imagePath: Assets.imagesPattern,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 294.74,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(height: h(context, 8)),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ReceivedMessageWidget(
                                avatar: Assets.imagesStevanoClirover,
                                text: AppLocalizations.of(context)!.justtoorder,
                                time: '09.00',
                              ),
                              SentMessageWidget(
                                text: AppLocalizations.of(context)!
                                    .okayforwhatlevelofspiciness,
                                time: '09.15',
                                isRead: true,
                              ),
                              ReceivedMessageWidget(
                                avatar: Assets.imagesStevanoClirover,
                                text: AppLocalizations.of(context)!
                                    .okayWaitaminute,
                                time: '09.00',
                              ),
                              SentMessageWidget(
                                text:
                                    AppLocalizations.of(context)!.okayImwaiting,
                                time: '09.15',
                                isRead: true,
                              ),
                            ],
                          ),
                          SizedBox(height: h(context, 265)),
                          ChatInputWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
