import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/chat/chat.dart';
import 'package:foodapp/view/screens/chat/user_tile.dart';
import 'package:foodapp/view/screens/services/auth_services.dart';
import 'package:foodapp/view/screens/services/chat_service.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListScreen extends StatelessWidget {
  final ChatService _chatService = ChatService();
  final AuthService _authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: h(context, 60),
            title: Row(
              children: [
                Padding(
                  padding: only(context, left: 50),
                  child: CustomText(
                    fontFamily: AppFonts.Inter,
                    text: AppLocalizations.of(context)!.chatlist,
                    size: 16,
                    weight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kTransparentColor,
            pinned: true,
            centerTitle: true,
            expandedHeight: h(context, 150),
            flexibleSpace: FlexibleSpaceBar(
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
                Padding(
                  padding: symmetric(
                    context,
                    horizontal: 24,
                  ),
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
                    ],
                  ),
                ),
                SizedBox(height: h(context, 16)),
                // Add the chat list stream
                Container(
                  height: h(context, 500), // Set a suitable height for the list
                  child: buildUserList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error loading users.'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // Ensure displayName always has a value
    String displayName =
        userData['username'] ?? 'Unknown User'; // Fallback to 'Unknown User'
    String lastMessage = userData['lastMessage'] ??
        ''; // Default to empty string if no last message
    String lastMessageTime =
        userData['lastMessageTime'] ?? ''; // Fetch time of last message
    int unreadCount = userData['unreadCount'] ?? 0; // Dynamic unread count
    bool isRead = userData['isRead'] ?? false; // Track read status

    // Check if the current user is not the one in userData
    if (userData['email'] != _authService.getCurrentUser()?.email) {
      return UserTile(
        text:
            displayName, // Always show the display name (fallback to 'Unknown User' if missing)
        lastMessage: lastMessage,
        time: lastMessageTime,
        unreadCount: unreadCount,
        showBadge: unreadCount > 0,
        isRead: isRead,
        onTap: () {
          // Get the current user's ID
          String currentUserId = _authService.getCurrentUser()?.uid ?? '';

          // Ensure both userId and otherUserId are valid
          if (currentUserId.isNotEmpty && userData['uid'] != null) {
            _chatService.markMessagesAsRead(currentUserId, userData['uid']);
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                receiverEmail: userData['email'],
                receiverUserID: userData['uid'],
                receiverName: displayName,
              ),
            ),
          );
        },
      );
    } else {
      return Container(); // Return an empty container for the current user
    }
  }
}
