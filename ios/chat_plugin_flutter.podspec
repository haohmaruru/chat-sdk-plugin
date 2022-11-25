#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint chat_plugin_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'chat_plugin_flutter'
  s.version          = '1.0.0'
  s.summary          = 'A Chat Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/haohmaruru/chat-sdk-plugin'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Hura' => 'minhnc@netacom.vn' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.5.2'
  
#  s.dependency 'ResolverVND'
  
  # chat sdk
  s.dependency 'NetacomSDKs','0.1.2'
  s.dependency 'NotificationSDK','0.1.2'
  s.dependency 'WebRTC'
  s.dependency 'Resolver'
  s.dependency 'MessageKit'

#   s.preserve_paths = 'sdk/WebRTC.xcframework', 'sdk/Resolver.xcframework', 'sdk/MessageKit.xcframework', 'sdk/InputBarAccessoryView.xcframework'
#   s.xcconfig = { 'OTHER_LDFLAGS' => '-framework WebRTC -framework Resolver -framework MessageKit -framework InputBarAccessoryView' }
#   s.vendored_frameworks = 'sdk/WebRTC.xcframework', 'sdk/Resolver.xcframework', 'sdk/MessageKit.xcframework', 'sdk/InputBarAccessoryView.xcframework'
#   s.resource_bundle = { 'WebRTC-Resources' => './*' }
end
