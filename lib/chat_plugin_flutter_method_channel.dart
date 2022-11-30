import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'chat_plugin_flutter_platform_interface.dart';
import 'model/config.dart';
import 'model/user.dart';

/// An implementation of [ChatPluginFlutterPlatform] that uses method channels.
class MethodChannelChatPluginFlutter extends ChatPluginFlutterPlatform {
  /// The method channel used to interact with the native platform.
  bool hasInit = false;
  @visibleForTesting
  final methodChannel = const MethodChannel('chat_plugin_flutter');

  @override
  Future<void> initChatSDK(ChatConfig config) async {
    if (!hasInit) {
      await methodChannel.invokeMethod('initChatSDK', config.toJson());
      hasInit = true;
    }
  }

  @override
  Future<void> openChatConversation() async {
    await methodChannel.invokeMethod('openChatConversation');
  }

  @override
  Future<void> setUser(ChatUser user) async {
    await methodChannel.invokeMethod('setUser', user.toJson());
  }

  @override
  Future<void> openChatWithAnother(ChatUser user) async {
    await methodChannel.invokeMethod('openChatWithAnother', user.toJson());
  }

  @override
  Future<void> logout() async {
    await methodChannel.invokeMethod('logout');
  }
}
