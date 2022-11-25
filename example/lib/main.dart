import 'dart:async';

import 'package:chat_plugin_flutter/chat_plugin_flutter.dart';
import 'package:chat_plugin_flutter/model/config.dart';
import 'package:chat_plugin_flutter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final HuraConfig config = HuraConfig(
    appId: 17,
    appKey: "B2D89AC8B8ECF",
    accountKey: "adminkey",
    iosConfig: IosConfig(
      storeUrl: "https://apps.apple.com/vn/app/vndirect/id1594533471",
      appGroupIdentifier: "group.vn.com.vndirect.stockchat",
    ),
  );
  late final ChatPluginFlutter _huraChatFlutterPlugin =
      ChatPluginFlutter(config);

  final user = ChatUser(
      id: 4785074606697392,
      username: "son1990",
      phone: "+84101000899",
      token: "0975295ac599d56c4129bdce1f5985bba994287X");

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      _huraChatFlutterPlugin.initChatSDK();
      _huraChatFlutterPlugin.setUser(user);
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
                  _huraChatFlutterPlugin.setUser(user);
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
                  _huraChatFlutterPlugin.openChatWithAnother(
                      ChatUser(id: 4785074605935470, username: "Test123"));
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
                  _huraChatFlutterPlugin.openChatConversation();
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
