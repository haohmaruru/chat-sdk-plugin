import 'dart:async';

import 'package:chat_plugin_flutter/chat_plugin_flutter.dart';
import 'package:chat_plugin_flutter/model/config.dart';
import 'package:chat_plugin_flutter/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'PushNotificationManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

late final ChatPluginFlutter chatFlutterPlugin = ChatPluginFlutter(config);
final ChatConfig config = ChatConfig(
    appId: 1,
    appKey: "appKey",
    accountKey: "adminkey",
    iosConfig: IosConfig(
      storeUrl: "https://apps.apple.com/vn/app/vndirect/id1594533471",
      appGroupIdentifier: "group.hura.asia",
    ),
    androidConfig: AndroidConfig());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

// Dapp
//   final HuraConfig config = HuraConfig(
//     appId: 17,
//     appKey: "B2D89AC8B8ECF",
//     accountKey: "adminkey",
//     iosConfig: IosConfig(
//       storeUrl: "https://apps.apple.com/vn/app/vndirect/id1594533471",
//       appGroupIdentifier: "group.vn.com.vndirect.stockchat",
//     ),
//   );
//
//   final user = ChatUser(
//       id: 4785074606697392,
//       username: "son1990",
//       phone: "+84101000899",
//       token: "0975295ac599d56c4129bdce1f5985bba994287X");
//
//   final userAnother = ChatUser(id: 4785074605935470, username: "Test123");

  // hura

  final user = ChatUser(
      id: 2814749772802146,
      username: "+84101000000",
      phone: "+84101000000",
      token: "0985beed219fe36442c0885a82a52630ec34993H");

  final userAnother = ChatUser(id: 2814749772645824, username: "0101111111");

  @override
  void initState() {
    super.initState();
    PushNotificationManager().init();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      chatFlutterPlugin.initChatSDK();
      // _huraChatFlutterPlugin.setUser(user);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
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
              Text('Running on: $_platformVersion\n'),
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
                  // _huraChatFlutterPlugin.setUser(user);
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
