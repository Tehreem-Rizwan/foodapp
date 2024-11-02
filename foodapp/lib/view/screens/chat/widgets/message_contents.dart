import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/screens/chat/models/message.dart';

class MessageContents extends StatelessWidget {
  const MessageContents({
    super.key,
    required this.message,
    this.isSentMessage = false,
  });

  final Message message;
  final bool isSentMessage;

  @override
  Widget build(BuildContext context) {
    if (message.messageType == 'text') {
      return Text(
        message.message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isSentMessage ? kSecondaryColor : kPrimaryColor,
        ),
      );
    } else if (message.messageType == 'image') {
      // Display the image from the URL
      return Image.network(
        message.message, // The fileUrl for the image
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error, color: Colors.red);
        },
      );
    } else if (message.messageType == 'video') {
      // Handle video here (you can integrate a video player widget)
      return Text(
        'Video content: ${message.message}', // Placeholder for video content
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isSentMessage ? kSecondaryColor : kPrimaryColor,
        ),
      );
    } else {
      return Text(
        'Unsupported file type',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
      );
    }
  }
}
