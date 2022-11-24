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
      appId: 1,
      appKey: "appKey",
      accountKey: "adminkey",
      iosConfig: IosConfig(storeUrl: "https://apps.apple.com"));
  late final ChatPluginFlutter _huraChatFlutterPlugin =
      ChatPluginFlutter(config);

  final user = ChatUser(
      id: 281474976981364,
      username: "Toan 0000",
      token: "0409ae9d38d088be45dab6e598229f21eb2c9CXW");

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
                  _huraChatFlutterPlugin
                      .openChatWithAnother(ChatUser(id: 2814749772693227));
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
