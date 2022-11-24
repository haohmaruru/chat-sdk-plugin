import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'chat_plugin_flutter_method_channel.dart';
import 'model/config.dart';
import 'model/user.dart';

abstract class ChatPluginFlutterPlatform extends PlatformInterface {
  /// Constructs a ChatPluginFlutterPlatform.
  ChatPluginFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ChatPluginFlutterPlatform _instance = MethodChannelChatPluginFlutter();

  /// The default instance of [ChatPluginFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelChatPluginFlutter].
  static ChatPluginFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ChatPluginFlutterPlatform] when
  /// they register themselves.
  static set instance(ChatPluginFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initChatSDK(HuraConfig config) {
    throw UnimplementedError('initChatSDK() has not been implemented.');
  }

  Future<void> openChatConversation() {
    throw UnimplementedError(
        'openChatConversation() has not been implemented.');
  }

  Future<void> setUser(ChatUser user) {
    throw UnimplementedError('setUser() has not been implemented.');
  }

  Future<void> openChatWithAnother(ChatUser user) {
    throw UnimplementedError('openChatWithAnother() has not been implemented.');
  }
}
