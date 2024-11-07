import 'dart:convert';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodapp/view/screens/home/notification/messsage_screen.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title.toString()}");
        print("notifications body:${notification.body.toString()}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('user denied permission');
      }
      Future.delayed(Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        showBadge: true,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: channel.sound
            //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
            //  icon: largeIconPath
            );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          message.hashCode, // Unique ID for the notification
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
          payload: "my_data");
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "foodapp-59c36",
      "private_key_id": "6353a6b7a1554674efaf25f912b2a628c6e1212a",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC0wqYX/68PwdTG\njUcwsYpFO94VWRk+hNV8kK1Xi7NdiINt9jY/9wOsiBtrshOr9akOalfBZYiIDRnj\nxJOQv2TtM7TGs57tk+OkIRlyDuB4njBnyH07IMrGTkhfPg5JoeoojXo3YOCNM3IW\ntRz3xrYiya9sVBoQjmiX85N4CQwpexGt5Zc+plAdEdXoCuOU7Ca+fobATc4nGqZN\n9RNwl5gTKOPxhvnNuO3EFELvMwgTi5udUISsTeQ2kGSJP76fzI8yB6FMVoxeQRqx\nwwvR/E7CdpJXTZbRuswgT+z2jl7KSuEAJh1j2y8bTQVUtqfdfThgYS8T7B96Cb88\nytwwEcq/AgMBAAECggEAPnG/zyqU32ymhLDplvi+O4yi+9z7y4038wBH4aZxIC64\nuJQFybMboc6jKmEqSo1jCYfTKQxaTiW4e+a805RK2WazXLFQheJBEcIdeDmLch+z\nuSaZnIOHiVohxkU5ylYU/k1hmx/sctsC3rVSfIY5BWuHHnUvS+jmWRfcKet2OB2m\nzw/QQDyzT6ZhC0IfK+ZJ5YhyS1eBMS+QIgiOlYuPxYET928iTTTQvBw8CkbQF1BM\nDWg7WGoNPVbd8vnP0R2u0AqUnwUU/93dMuIOnxxwhICMlX2TqLD3j0zkvraCcN3k\non2433/j2tPfcAfV6btTL8Gy09YXx02DxEBG/hOIgQKBgQDmzKIuRkQSnqYaNJfY\noPlLEJIBDi0zX/6F054DzIXS8toHBPMJzRC66QeHQJMXAzEH7/sTXAWt35wY8BVS\nA1AlccmCtg48GveRpIZf914OgzdfeeE/kMP22Re/lskyzeqao2/okIA9dbZ541kn\ngN9+joT5bWxyVczaUThWg6j8TQKBgQDIf0+4ZJuNI6vFRWo9oe5FBXZLN1qJrFNK\ny3ltvXbX7gDHqQ9lGS52sJFvcRSEWlheJq6JXlUsqtqoeq8BkJLZCqzJ/Uvi7pW8\nPkY+NDqRplvFhZAPLV9mu9yWLPxWx7mWJJmscb2wCHaWQPpKbia3V69QAH7SQmQ1\nlwme1vy5OwKBgQDdpJ0HJXGQFA1d0y4T2pstjE86djvQP5q1OEFiUpIdwBzDauxf\neDBd3xXcvJXFHsqCXeNXdyL5FGnaxQ0kgowAOaMURPOsoxUnJ8Hn/S21cCvII8q9\n+a9HqroUwqCbioaHVPdOdx7AZwADU+K1fhyjdAidZIklz+H3stIQu0WYbQKBgQCR\nAGoCXFiXIZYnzIUCX+s3ZbTgvv6ulL+EV1XRhPW/QnSz8VOd9TFCS35TD4AcHE7O\ngME3vc5xyHrs4BVTV2CssWi3iIXqcExAYPViJVm6Xor+dhLytwjI/tKQlaZFiJpy\nuLOfIH9kISrKjeG2FKXRcQvsGv+dRsC8dShTBP6vYwKBgQCfl8Gi6oBJiJSwB9KR\n/go67kvQ5uQlSs/JCnRKhUA8tiLD5bHnEuop2iJ+ycqs6E8WS9f1pB9vznPGnjUc\nixKcn3dFZlwFEwA/+F7/rwd2yJLNBS+ox1sRmTsL4tS+Bz5FahoByX6k2qDZzaKy\nozEnJs9CzIkd0G97EbS0cLYuig==\n-----END PRIVATE KEY-----\n",
      "client_email": "flutter-food-app@foodapp-59c36.iam.gserviceaccount.com",
      "client_id": "112167288519685780478",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/flutter-food-app%40foodapp-59c36.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database"
    ];
    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msg') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MessageScreen(
                    id: message.data['id'],
                  )));
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
