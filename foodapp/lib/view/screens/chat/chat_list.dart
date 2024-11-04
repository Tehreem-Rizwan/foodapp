import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/view/screens/chat/chat.dart';
import 'package:foodapp/view/screens/chat/user_tile.dart';
import 'package:foodapp/view/screens/services/auth_services.dart';
import 'package:foodapp/view/screens/services/chat_service.dart';
import 'package:get/get.dart';

class ChatListScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ChatService _chatService = ChatService();
  final AuthService _authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
      ),
      body: buildUserList(),
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
              .toList()
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // Check if 'name' is null and use email as a fallback, or a default string if both are null
    String displayName =
        userData['name'] ?? userData['email'] ?? 'Unknown User';

    // Avoid displaying the current user in the list
    if (userData['email'] != _authService.getCurrentUser()?.email) {
      return UserTile(
        text: displayName, // Display the user's name or fallback value
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
      return Container(); // Don't show the current user
    }
  }
}
