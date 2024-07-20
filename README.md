# Solve Cloud Messaging API Legacy

This repository provides a solution for handling notifications using Firebase Cloud Messaging (FCM) with the latest API. The provided code helps in sending notifications to devices using FCM tokens.

## Overview

The project contains two main files:

1. `notifications_helper.dart` - Handles the initialization of Firebase Messaging, obtaining device tokens, and sending notifications.
2. `body.json` - JSON structure for the notification body used in the `sendNotifications` method.

## Notification Helper

The `NotificationsHelper` class is designed to manage the process of sending notifications through Firebase Cloud Messaging (FCM). Below is a breakdown of the functionalities provided by this class.

### notifications_helper.dart

#### Code Explanation

```dart
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../components/components.dart';
import '../constants.dart';

class NotificationsHelper {
  // Create instance of FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // Get device token
    String? deviceToken = await _firebaseMessaging.getToken();
    DeviceToken = deviceToken;
    print("===================Device FirebaseMessaging Token====================");
    print(deviceToken);
    print("===================Device FirebaseMessaging Token====================");
  }

  // Handle notifications when received
  void handleMessages(RemoteMessage? message) {
    if (message != null) {
      // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
      showToast(
          text: 'on Background Message notification',
          state: ToastStates.SUCCESS);
    }
  }

  // Handle notifications in case app is terminated
  void handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "",
      "project_id": "",
      "private_key_id": "",
      "private_key":"",
      "client_email": "",
      "client_id": "",
      "auth_uri": "",
      "token_uri": "",
      "auth_provider_x509_cert_url": "",
      "client_x509_cert_url": "",
      "universe_domain": ""
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();
      print(
          "Access Token: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "android": {
          "notification": {
            "priority": "PRIORITY_MAX",
            "sound": "default",
            "default_vibrate_timings": true,
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();
      // Change your project ID
      const String urlEndPoint = "https://fcm.googleapis.com/v1/projects/(YourProjectId)/messages:send";

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
        urlEndPoint,
        data: getBody(
          userId: userId,
          fcmToken: fcmToken,
          title: title,
          body: body,
          type: type ?? "message",
        ),
      );

      // Print response status code and body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
