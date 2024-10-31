import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send a message
  Future<void> sendMessage(
      String senderId, String receiverId, String message) async {
    await _firestore.collection('chats').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false, // Message is unread when sent
    });
  }

  // Listen to messages between two users in real-time
  Stream<QuerySnapshot> getMessages(String senderId, String receiverId) {
    return _firestore
        .collection('chats')
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
