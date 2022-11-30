import 'chat_plugin_flutter_platform_interface.dart';
import 'model/config.dart';
import 'model/user.dart';

class ChatPluginFlutter {
  ChatConfig config;

  ChatPluginFlutter(this.config);

  Future<void> initChatSDK() async {
    await ChatPluginFlutterPlatform.instance.initChatSDK(config);
  }

  Future<void> openChatConversation() async {
    await ChatPluginFlutterPlatform.instance.openChatConversation();
  }

  Future<void> setUser(ChatUser user) async {
    await ChatPluginFlutterPlatform.instance.setUser(user);
  }

  Future<void> openChatWithAnother(ChatUser user) async {
    await ChatPluginFlutterPlatform.instance.openChatWithAnother(user);
  }

  Future<void> logout() async {
    await ChatPluginFlutterPlatform.instance.logout();
  }
}
