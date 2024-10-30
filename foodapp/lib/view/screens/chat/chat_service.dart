import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodapp/view/screens/chat/chat_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    await _firestore.collection('messages').add(message.toMap());
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
  }
}
