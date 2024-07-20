# Solve-Cloud-Messaging-API-Legacy

This repository contains a solution to handle Firebase Cloud Messaging (FCM) using the Legacy API with Flutter. The solution includes two files:
1. `notification_helper.dart` - Handles the sending of notifications using FCM and managing access tokens.
2. `body.json` - The JSON body structure used for sending notifications.

## Overview

### 1. `notification_helper.dart`

This Dart file provides a class `NotificationsHelper` that includes methods to:
- Initialize FCM and get the device token.
- Handle received notifications.
- Obtain an OAuth 2.0 access token using a service account.
- Send notifications to specific devices using FCM.

#### Key Methods

- `initNotifications()`: Requests permission for notifications and retrieves the device token.
- `handleMessages(RemoteMessage? message)`: Handles incoming messages and displays a toast notification.
- `handleBackgroundNotifications()`: Handles notifications when the app is terminated.
- `getAccessToken()`: Retrieves an OAuth 2.0 access token using a service account.
- `getBody({required String fcmToken, required String title, required String body, required String userId, String? type})`: Constructs the notification payload.
- `sendNotifications({required String fcmToken, required String title, required String body, required String userId, String? type})`: Sends the notification using the FCM HTTP v1 API.

### 2. `body.json`

This JSON file provides the structure of the notification payload sent to FCM.

#### Example JSON Structure
```json
{
  "message": {
    "token": "device token",
    "notification": {
      "title": "Notification Title",
      "body": "Notification Body"
    },
    "android": {
      "notification": {
        "notification_priority": "PRIORITY_MAX",
        "sound": "default"
      }
    },
    "apns": {
      "payload": {
        "aps": {
          "content_available": true
        }
      }
    },
    "data": {
      "type": "type",
      "id": "userId",
      "click_action": "FLUTTER_NOTIFICATION_CLICK"
    }
  }
}
