import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodapp/constants/app_styling.dart';

class ChatInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputWidget({
    Key? key,
    required this.controller,
    required this.onSend,
  }) : super(key: key);

  @override
  _ChatInputWidgetState createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
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

  // Function to send the message or file URL to Firebase
  Future<void> _sendMessageToFirebase(String? fileUrl) async {
    final message = widget.controller.text.trim();
    if (message.isNotEmpty || fileUrl != null) {
      await FirebaseFirestore.instance.collection('chats').add({
        'text': message,
        'fileUrl': fileUrl ?? '',
        'createdAt': Timestamp.now(),
        'isRead': false,
        'senderId': 'your_sender_id', // Replace with actual sender ID
      });
      widget.controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    border: Border.all(color: const Color(0xFFD6D6D6)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image(
                          image: AssetImage(Assets.imagesEmoji),
                          color: kgreyblackColor,
                        ),
                      ),
                      SizedBox(width: w(context, 16)),
                      Expanded(
                        child: TextField(
                          controller: widget.controller,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.typesomething,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: kgreyblackColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickFile,
                        child: Image(
                          image: AssetImage(Assets.imagesAttachment),
                          color: kgreyblackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: w(context, 8)),
              GestureDetector(
                onTap: () async {
                  if (widget.controller.text.isNotEmpty) {
                    await _sendMessageToFirebase(null);
                    widget.onSend();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kTertiaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.send, color: kSecondaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
