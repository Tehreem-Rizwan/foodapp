import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/view/screens/chat/providers/chat_tile.dart';
import 'package:foodapp/view/screens/chat/providers/get_all_chats_provider.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_chat_item_chat_list_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch all chats
    final chatsList = ref.watch(getAllChatsProvider);
    final myUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          fontFamily: AppFonts.Inter,
          text: AppLocalizations.of(context)!.chatlist,
          size: 16,
          weight: FontWeight.w600,
          color: kPrimaryColor,
        ),
        backgroundColor: kTransparentColor,
        automaticallyImplyLeading: false, // Removes back arrow
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          background: CommonImageView(
            imagePath: Assets.imagesPattern,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: chatsList.when(
        data: (chats) {
          if (chats.isEmpty) {
            return Center(
              child: Text('No chats available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats.elementAt(index);
              final userId =
                  chat.members.firstWhere((userId) => userId != myUid);

              return ChatTile(
                userId: userId,
                lastMessage: chat.lastMessage,
                lastMessageTs: chat.lastMessageTs,
                chatroomId: chat.chatroomId,
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error: ${error.toString()}'));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
