import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  bool isInit = false;

  init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    onReceiverMessage();
    isInit = true;
  }

  void onReceiverMessage() async {
    //FirebaseMessaging.instance.subscribeToTopic(topic);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("Firebase message: ${message.data.toString()}");
      }
    });
    if (!isInit) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        try {
          var notification = _getNotification(message);
          print("Firebase onMessage: ${message.data.toString()}");
        } catch (e) {
          print(e);
        }
      });
      //Truong hop app chay background nhung chua tat han
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("Firebase onMessageOpenedApp: ${message.data.toString()}");
      });
    }

    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print("Firebasetoken: $token");
    }
  }

  RemoteNotification? _getNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    return notification ?? null;
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
