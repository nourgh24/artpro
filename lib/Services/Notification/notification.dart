
import 'package:flutter_fcm/flutter_fcm.dart';
import '../Constants/app_constants.dart';

class Messaging {
  static String? token;

  static Future<void> onNotificationReceived(RemoteMessage message) async {
    await Firebase.initializeApp();

    print('Handling a message ${message.messageId}');
  }


  static initFCM() async {
    print("jjjjjjjjjjjjjjjjj");
    print(Messaging.token);

     try {
      await FCM.initializeFCM(
        onNotificationReceived: onNotificationReceived,
        withLocalNotification: true,
        onNotificationPressed: (Map<String?, dynamic>? data) {
          // Notifications notification = Notifications.fromFCM(data);
          // NotificationMiddleware.forward(notification);
        },
        onTokenChanged: (String? token) {
          Messaging.token = token;
          // if (SharedStorage.hasToken()) {
          //   NotificationRepository.uploadNotificationsToken(Messaging.token);
          // }

          print("token");
          print(token);
        },
        icon: 'app_logo',
        navigatorKey: Keys.navigatorKey,
      );
    } catch (e) {
      print("eeeeeeeeeeeeeeeeee");
      print(e);
    }
  }
}
