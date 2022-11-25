import UIKit
import Flutter
import chat_plugin_flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        //   start sdk chat
        SwiftChatPluginFlutterPlugin.instance.setOnInitChatConfigListener {
            let _ = SwiftChatPluginFlutterPlugin.instance.application(application, didFinishLaunchingWithOptions: launchOptions)
            print("AppDelegate initChatListener")
        }
        //  end sdk chat
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    //   start sdk chat
    public override func applicationDidBecomeActive(_ application: UIApplication) {
        SwiftChatPluginFlutterPlugin.instance.applicationDidBecomeActive(application)
    }
    
    public override func applicationWillResignActive(_ application: UIApplication) {
        SwiftChatPluginFlutterPlugin.instance.applicationWillResignActive(application)
    }
    
    public override func applicationWillTerminate(_ application: UIApplication) {
        SwiftChatPluginFlutterPlugin.instance.applicationWillTerminate(application)
    }
    
    // UserActivity
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        SwiftChatPluginFlutterPlugin.instance.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
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
}
