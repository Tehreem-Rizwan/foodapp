import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
    String displayName = userData['username'] ??
        'Unknown User'; // Fallback if 'username' is null

    if (userData['email'] != _authService.getCurrentUser()?.email) {
      return UserTile(
        text: displayName,
        onTap: () {
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
      return Container();
    }
  }
}
