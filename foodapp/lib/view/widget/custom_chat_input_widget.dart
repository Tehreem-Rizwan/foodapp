import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/view/screens/chat/providers/chat_provider.dart'; // Import Riverpod for state management

class ChatInputWidget extends ConsumerStatefulWidget {
  // Changed to ConsumerStatefulWidget for Riverpod
  final TextEditingController messageController;
  final String chatroomId; // Add chatroomId
  final String receiverId;

  const ChatInputWidget({
    Key? key,
    required this.messageController,
    required this.chatroomId, // Pass chatroomId
    required this.receiverId,
  }) : super(key: key);

  @override
  _ChatInputWidgetState createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends ConsumerState<ChatInputWidget> {
  FilePickerResult? fileResult;

  Future<void> _pickFile() async {
    fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null && fileResult!.files.single.path != null) {
      final filePath = fileResult!.files.single.path!;
      String fileName = fileResult!.files.single.name;
      await _uploadFileToFirebase(File(filePath), fileName);
    }
  }

  Future<void> _uploadFileToFirebase(File file, String fileName) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child("chat_files/$fileName");
      await storageRef.putFile(file);
      String downloadUrl = await storageRef.getDownloadURL();
      _sendMessageToFirebase(downloadUrl);
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  Future<void> _sendMessageToFirebase(String? fileUrl) async {
    final message = widget.messageController.text.trim();
    if (message.isNotEmpty || fileUrl != null) {
      await FirebaseFirestore.instance.collection('chats').add({
        'text': message.isEmpty ? null : message,
        'fileUrl': fileUrl ?? '',
        'createdAt': Timestamp.now(),
        'isRead': false,
        'senderId': 'your_sender_id',
      });
      widget.messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.emoji_emotions_outlined),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: widget.messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickFile,
                    child: Icon(Icons.attach_file),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              if (widget.messageController.text.isNotEmpty) {
                await ref.read(chatProvider).sendMessage(
                      message: widget.messageController.text,
                      chatroomId: widget.chatroomId,
                      receiverId: widget.receiverId,
                    );
                widget.messageController.clear();
              }
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.send, color: kSecondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
