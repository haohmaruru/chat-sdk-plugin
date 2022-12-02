import 'chat_plugin_flutter_platform_interface.dart';
import 'model/config.dart';
import 'model/user.dart';

class ChatPluginFlutter {
  ChatConfig? _config;

  ChatPluginFlutter._internal();

  static final ChatPluginFlutter _singleton = ChatPluginFlutter._internal();

  factory ChatPluginFlutter() {
    return _singleton;
  }

  factory ChatPluginFlutter.config(ChatConfig config) {
    _singleton._config = config;
    return _singleton;
  }

  setConfig(ChatConfig config) {
    _config = config;
  }

  _checkConfig() {
    if (_config == null) {
      throw Exception('Not set Chat Config yet');
    }
  }

  Future<void> initChatSDK() async {
    _checkConfig();
    await ChatPluginFlutterPlatform.instance.initChatSDK(_config!);
  }

  Future<void> openChatConversation() async {
    _checkConfig();
    await ChatPluginFlutterPlatform.instance.openChatConversation();
  }

  Future<void> setUser(ChatUser user) async {
    _checkConfig();
    await ChatPluginFlutterPlatform.instance.setUser(user);
  }

  Future<void> openChatWithAnother(ChatUser user) async {
    _checkConfig();
    await ChatPluginFlutterPlatform.instance.openChatWithAnother(user);
  }

  Future<void> logout() async {
    _checkConfig();
    await ChatPluginFlutterPlatform.instance.logout();
  }

  @override
  Future<void> handleChatNotification(
      Map<String, dynamic> remoteMessageData) async {
    _checkConfig();
    await ChatPluginFlutterPlatform.instance
        .handleChatNotification(remoteMessageData);
  }
}
