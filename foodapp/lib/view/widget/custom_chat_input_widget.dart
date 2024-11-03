import 'dart:io'; // Import the File class
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/screens/services/chat_service.dart';

class ChatInputWidget extends StatefulWidget {
  final String receiverUserID;

  const ChatInputWidget({
    Key? key,
    required this.receiverUserID,
  }) : super(key: key);

  @override
  _ChatInputWidgetState createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  FilePickerResult? fileResult;
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  Future<void> _pickFile() async {
    fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null && fileResult!.files.single.path != null) {
      final filePath = fileResult!.files.single.path!;
      String fileName = fileResult!.files.single.name;
      await _uploadFileToFirebase(File(filePath), fileName);
    }
  }

  // Function to upload the file to Firebase Storage
  Future<void> _uploadFileToFirebase(File file, String fileName) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child("chat_files/$fileName");
      await storageRef.putFile(file);
      String downloadUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        child: Image(
                          image: AssetImage(Assets.imagesEmoji),
                          color: kgreyblackColor,
                        ),
                      ),
                      SizedBox(width: w(context, 16)),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
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
                onTap: sendMessage,
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
