import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/model/message.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get list of users
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // Send a message and mark it as unread initially
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // Create a new message object with isRead set to false
    Message newMessage = Message(
      senderId: currentUserId,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      senderEmail: currentUserEmail,
      isRead: false, // Add isRead field to the message
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // To create a unique chat room ID
    String chatRoomId = ids.join("_");

    // Save the message to Firestore
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());

    // Update unread message count for the receiver
    await _firestore.collection('users').doc(receiverId).update({
      'unreadMessageCount': FieldValue.increment(1), // Increase unread count
    });
  }

  // Fetch messages between two users
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // Mark messages as read when the user opens the chat
  Future<void> markMessagesAsRead(String userId, String otherUserId) async {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Get unread messages where the receiver is the current user and isRead is false
    var messages = await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection("messages")
        .where('receiverId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    // Mark messages as read
    for (var doc in messages.docs) {
      await doc.reference.update({'isRead': true});
    }

    // Reset unread message count for the user
    await _firestore.collection('users').doc(userId).update({
      'unreadMessageCount': 0, // Reset unread count to 0 after reading
    });
  }

  Map<String, dynamic> getLastMessageForUser(String userId) {
    // Your logic to fetch the last message
    // Return an empty map or a map with defaults if no messages are found
    return {
      'message': '',
      'time': '',
      'unreadCount': 0,
      'isRead': false,
    };
  }
}
