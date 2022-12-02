import 'package:chat_plugin_flutter/chat_plugin_flutter.dart';
import 'package:chat_plugin_flutter/model/config.dart';
import 'package:chat_plugin_flutter/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'PushNotificationManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

const int your_app_id = 0; // must replace for your app
const String your_app_key = ""; // must replace for your app
const String your_account_key = ""; // must replace for your app
const String your_store_url = ""; // must replace for your app
const String your_app_group = ""; // must replace for your app ios
final ChatConfig config = ChatConfig(
    appId: your_app_id,
    appKey: your_app_key,
    accountKey: your_account_key,
    iosConfig: IosConfig(
      storeUrl: your_store_url,
      appGroupIdentifier: your_app_group,
    ),
    androidConfig: AndroidConfig());

final ChatPluginFlutter chatFlutterPlugin = ChatPluginFlutter.config(config);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  final user = ChatUser(); // let set your user info

  final userAnother = ChatUser(); // let set your user info

  @override
  void initState() {
    super.initState();
    PushNotificationManager().init();
    chatFlutterPlugin.initChatSDK();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  // _huraChatFlutterPlugin.setUser(user);
                  chatFlutterPlugin.setUser(user);
                },
                child: Text(
                  "****set user***",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  chatFlutterPlugin.openChatWithAnother(userAnother);
                },
                child: Text(
                  "chat with user",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  chatFlutterPlugin.openChatConversation();
                },
                child: Text(
                  "open chat conversation",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
