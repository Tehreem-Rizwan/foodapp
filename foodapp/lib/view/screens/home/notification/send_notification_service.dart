import 'dart:convert';

import 'package:foodapp/view/screens/home/notification/notification_services.dart';
import 'package:http/http.dart' as http;

class SendNotificationService {
  static Future<void> sendNotificationUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    String serverKey = await NotificationServices.getAccessToken();
    print("notification server key => $serverKey");
    String url =
        "https://fcm.googleapis.com/v1/projects/foodapp-59c36/messages:send";

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"body": body, "title": title},
        "data": data,
      }
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully!");
    } else {
      print("Notification not sent! Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }
}
