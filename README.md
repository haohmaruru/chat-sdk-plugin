# Chat Flutter Plugin

Supply a chat sdk simple for flutter project.

## Features

- Import a Contact from your phone to chat contact.
- Conversation chat, chat detail
- Share location, image, video...
- Video call, audio call

## Use

Create a config:
```flutter
final ChatConfig config = ChatConfig(
    appId: your app id,
    appKey: your app key,
    accountKey: your account key,
    iosConfig: IosConfig(
      storeUrl: <your app store url>,
      appGroupIdentifier: <your app group>,
    ),
    androidConfig: AndroidConfig()
  );
```

Create instance of plugin:
```flutter
final ChatPluginFlutter _chatFlutterPlugin = ChatPluginFlutter(config);
```

Call method **initChatSDK()** be fore use:
```flutter
_chatFlutterPlugin.initChatSDK();
```

Set user:
```flutter
 _chatFlutterPlugin.setUser(user);
```

Open chat conversation (after set user):
```flutter
 _chatFlutterPlugin.openChatConversation();
```

Open chat with another (after set user):
```flutter
 _chatFlutterPlugin.openChatWithAnother(userAnother);
```
Logout:
```flutter
 _chatFlutterPlugin.logout();
```


## Installation

### Ios

**This sdk require ios >=13.0.**

Add dependencies to your **Podfile**

```swift
.... your dependencies ...

platform :ios, '13.0'
use_frameworks!

def netalo_sdks
  pod 'NetacomSDKs', :git => 'https://github.com/Netacom-NetAlo/NetaloSDKs-iOS', tag: '10.0.1'
end

def netalo_sdks_notification
  pod 'NotificationSDK', :git => 'https://github.com/Netacom-NetAlo/NotiSDKs-iOS', tag: '10.0.1'
end

def netalo_webrtc
  pod 'WebRTC', :git => 'https://github.com/Netacom-NetAlo/WebRTC-iOS', branch: 'main'
end

def netalo_resolver
  pod 'Resolver', :git => 'https://github.com/Netacom-NetAlo/Resolver-iOS', branch: 'main'
end

def netalo_messagekit
  pod 'MessageKit', :git => 'https://github.com/Netacom-NetAlo/Messagekit-iOS'
end
```

Add to target **Runner** in your **Podfile**

```swift
target 'Runner' do
  use_frameworks!
  use_modular_headers!
  
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
  .... your dependencies ...
  
  # sdk chat'
  netalo_sdks
  netalo_sdks_notification
  netalo_webrtc
  netalo_resolver
  netalo_messagekit
  # sdk chat
  
end
```

And add build_configurations in **Podfile**

```swift
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    # sdk chat
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['ARCHS'] = 'arm64 x86_64'
    end
    # sdk chat
    
  end
end
```

If you implement notification. Let add dependencies to target **NotificationExtension** in your **Podfile**

```swift
target 'NotificationExtension' do
  .... your dependencies ...
  
  # sdk chat'
  netalo_sdks_notification
  netalo_webrtc
  netalo_resolver
  # sdk chat
  
end
```

Add code to your **NotificationService**:

```swift
import UserNotifications
import RxSwift
import Resolver
import NotificationComponent

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    // start sdk chat
    private var disposeBag = DisposeBag()
    @LazyInjected private var notificationRepo: NotificationComponentImpl
    
    override init() {
        super.init()
        
        notificationRepo.initialize()
    }
    
    // end sdk chat
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        // start sdk chat
        if let bestAttemptContent = bestAttemptContent {
            notificationRepo.replace(oldContent: bestAttemptContent)
                .do(onSuccess: { (newContent) in
                    contentHandler(newContent)
                })
                    .subscribe()
                    .disposed(by: disposeBag)
                    }
        // end sdk chat
        
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            
            // start sdk chat
            contentHandler(
                notificationRepo.expired(oldContent: bestAttemptContent)
            )
            // end sdk chat
            
        }
    }
    
}
```

If you need to override some method of Notification then add code to these function. else No need to do anything.

```swift
public override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

.... your code ...

    # sdk chat'
    SwiftChatPluginFlutterPlugin.instance.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    # sdk chat'
}
    
public override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        .... your code ...
        
    # sdk chat'
    SwiftChatPluginFlutterPlugin.instance.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    # sdk chat'
}

public override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        .... your code ...
    
    # sdk chat'
    SwiftChatPluginFlutterPlugin.instance.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    # sdk chat'
}   
```


## Android
No need to do anything more


