import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../components/components.dart';
import '../constants.dart';

class NotificationsHelper {
  // creat instance of fbm
  final _firebaseMessaging = FirebaseMessaging.instance;

  // initialize notifications for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // get device token
    String? deviceToken = await _firebaseMessaging.getToken();
    DeviceToken = deviceToken;
    print(
        "===================Device FirebaseMessaging Token====================");
    print(deviceToken);
    print(
        "===================Device FirebaseMessaging Token====================");
  }

  // handle notifications when received
  void handleMessages(RemoteMessage? message) {
    if (message != null) {
      // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
      showToast(
          text: 'on Background Message notification',
          state: ToastStates.SUCCESS);
    }
  }

  // handel notifications in case app is terminated
  void handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "missing-egypt-a2a74",
      "private_key_id": "62f52c298a3017e941df8cce45cf81d2c0c90d52",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCS4H3UjsVV9QOr\nmGPCNWwS7WZS+4mhb/sZP0Kq41ia7+7RnQawgA1OnK4rU+DKzjOa/WASQDIbSIZ3\nVrZoMPPCKw5xdYP+LPeJDzVk8GazcFaFAo2rUGlWtZVKTad7ncI8mMGWE/G1Szqa\nE8xvlTgT8tFqYENUWbCl7MozUdOVYUEDO/NiHeb7vIUWq5MFH2ttGGxkhc+Ec/FL\nSB2HM5p5iq9AJXHQrnMhCuG9EKU1KAMxfKHifRPcfrTRxRS++x+LPTUt2KPTcdAo\nxSIWx7aTqPGbXnEp10A8A2AyzFsPzy2XlLObKR0/rk4lODxUBrFIzGEozNW8ynqB\nSI00JS1hAgMBAAECggEABHws83zxmzSaalbCsxdBB9nufjm2o/Kgsw5quX+sQLzz\naLy4C9M5NM2VhvauflrqGgFDOgNyVEF0c7f25XsbMnJwpDfPskcKvwlzGrQ5mqCj\nT7f6fgD8Wny8hJKW+vAgEowimzPcNWpI7ZQNsdmXZwqK6Qnr/GspuQNgUE1fHehY\nxUu1svZ2bIoJQn/gMYwu+pRgX6C8Wt6M53eIW8IkROkfyfrRJ9YbgRG3AAqNCAzm\nXuulYHPr9uVOl8PXs1kcW6+edEnZPwXQi0sk8aB9HuHLbNcAR1FZempBWb8XTyLN\n9CvIq8Iolcnwxl7VQhq1cjEVg8TvvtCT7xGkz7Y+QQKBgQDDqVuJWfK9XTkcnJnm\nNP3rMWqUj+ndZ1RE0DJz8VV047WR+UO41vFeFnjs9q3q6Ww3+ft9gdFOdBjXy8Lu\nZrBhwc9D3UIEIiSEQ1K1UltnA8Q+KNHrAoU+weElS33A/adDI9o6VlJw+g4QV/Wg\nBN+wDm+ZWp2Qoux8l7d3vXbvkQKBgQDAK8vBeaUd6g4hkpSTlzCwIzNt+eJFodIm\ntMjeaUFw9JpXb2s4I/NXN6JKADsgjhGjZIe5U+/Nnjevieb4nv3uU5YHErNGAU7j\nDU1MNXsmWzut5dB3ZumFbLx3urPPvH+4sb0+hCYZbS6TiEwn+VJ9vSglnx3GZWUC\n+nlm5zYY0QKBgEN17P2aabsonTxkMhvRQYsJ6rl2NSgFLGTdc8fN+aznpf7CdrsQ\nQQAzt1XcZ3KLMKjMJA3N6KCoHriopHkWJtJNxGydqNlL/FMt8yJZVvJZthvIbzgc\nElzk8/+r25vi2PypK+DZSmtxi8/Ow/18MLO/BnNVbuYjhm4e0T8TsCJBAoGAaDWX\nuaRQoOcyoIwPW/XJ5kpAcmvmgyIchvbUUp+7aBiMtctq1jfQlsRJkl2Lsry33eX/\nH8XfrZ4VznA2uy3kv9+95LoEU3sUH1YwS5pY3NTuiP+ty4IYMk1j6n1pUsaCcFKa\nMBOTYYhukHyB589xJ1RzN+uQRuznGPVg7ieFk3ECgYEAuv4floI1XfmDWdpcbA4P\n8qiCa6N6LuCqnlwyBfQlb5Qipft+ASlQKXnWsm9eVvAeTUqlHHHV3HzaUllgVWem\nYBz1Tv6oLeOYJhEghi86cXc3ztk/lQmPqwVupWs3BJkKm67k11AbWTTSrkL9NBd+\n6+2LwIJu7AOVCk7IrWvYlUY=\n-----END PRIVATE KEY-----\n",
      "client_email": "missing-eg@missing-egypt-a2a74.iam.gserviceaccount.com",
      "client_id": "102242598778623857726",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/missing-eg%40missing-egypt-a2a74.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
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
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
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
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/missing-egypt-a2a74/messages:send";

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
