import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_fonts.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/chat/call_screen.dart';
import 'package:foodapp/view/screens/chat/chat_%20bubble.dart';
import 'package:foodapp/view/screens/services/chat_service.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_chat_input_widget.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  ChatScreen({required this.receiverUserEmail, required this.receiverUserID});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
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
                        text: widget.receiverUserEmail,
                        size: 16,
                        weight: FontWeight.w600,
                        color: kBlackyColor,
                      ),
                      Padding(
                        padding: only(context, top: 8, left: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
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
                  expandedHeight: h(context, 30),
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
                  child: Container(
                    height: 300, // Adjust as per your design
                    child: CommonImageView(
                      imagePath: Assets.imagesPattern,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 294.74,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: h(context,
                        500), // Set an appropriate height for chat list
                    child: buildMessageList(),
                  ),
                ),
              ],
            ),
          ),
          ChatInputWidget(
            receiverUserID: widget.receiverUserID,
          ),
          SizedBox(height: h(context, 25)),
        ],
      ),
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseauth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseauth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            SizedBox(height: 5),
            ChatBubble(
              message: data['message'],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseauth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => buildMessageItem(document))
              .toList(),
        );
      },
    );
  }
}
