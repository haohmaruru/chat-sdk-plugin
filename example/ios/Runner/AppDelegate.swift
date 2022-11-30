import UIKit
import Flutter
import Firebase
import chat_plugin_flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        GeneratedPluginRegistrant.register(with: self)
        
        self.registerForRemoteNotification()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
    
        
        //   start sdk chat
    
//        SwiftChatPluginFlutterPlugin.instance.application(application, didFinishLaunchingWithOptions: launchOptions)
        //  end sdk chat

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func registerForRemoteNotification() {
            if #available(iOS 10.0, *) {
                let center  = UNUserNotificationCenter.current()

                center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                    if error == nil{
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }

            }
            else {
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    
//    //   start sdk chat
//    public override func applicationDidBecomeActive(_ application: UIApplication) {
//        SwiftChatPluginFlutterPlugin.instance.applicationDidBecomeActive(application)
//    }
//
//    public override func applicationWillResignActive(_ application: UIApplication) {
//        SwiftChatPluginFlutterPlugin.instance.applicationWillResignActive(application)
//    }
//
//    public override func applicationWillTerminate(_ application: UIApplication) {
//        SwiftChatPluginFlutterPlugin.instance.applicationWillTerminate(application)
//    }
//
//    // UserActivity
//    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        SwiftChatPluginFlutterPlugin.instance.application(application, continue: userActivity, restorationHandler: restorationHandler)
//    }
//
    // Notification methods
    public override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        SwiftChatPluginFlutterPlugin.instance.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        SwiftChatPluginFlutterPlugin.instance.application(application, open: url, sourceApplication: sourceApplication, annotation: application)
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        SwiftChatPluginFlutterPlugin.instance.application(app, open: url, options: options)
    }

    //  end sdk chat

    //  notification
    //  start sdk chat
    // MARK: - UNUserNotificationCenterDelegate
    public override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        SwiftChatPluginFlutterPlugin.instance.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }

    public override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        SwiftChatPluginFlutterPlugin.instance.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
    
    //  end sdk chat
}
