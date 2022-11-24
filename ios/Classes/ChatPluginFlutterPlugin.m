#import "ChatPluginFlutterPlugin.h"
#if __has_include(<chat_plugin_flutter/chat_plugin_flutter-Swift.h>)
#import <chat_plugin_flutter/chat_plugin_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "chat_plugin_flutter-Swift.h"
#endif

@implementation ChatPluginFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftChatPluginFlutterPlugin registerWithRegistrar:registrar];
}
@end
