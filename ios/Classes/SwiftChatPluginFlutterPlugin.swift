import Flutter
import UIKit
import NetAloLite
import XCoordinator
import NetAloFull
import NATheme
import RxCocoa
import RxSwift
import NADomain

public class SwiftChatPluginFlutterPlugin: NSObject, FlutterPlugin {
    private var netAloSDK: NetAloFullManager?
    private var disposeBag = DisposeBag()
    public static let instance = SwiftChatPluginFlutterPlugin()
    
    let subject = PublishSubject<String>()
    private var disposable:Disposable?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "chat_plugin_flutter", binaryMessenger: registrar.messenger())
        //        let instance = SwiftChatPluginFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "initChatSDK" :
            initChatSDK(call:call,result: result)
            break
        case "openChatConversation":
            openChatConversation()
            break
        case "setUser" :
            setUser(call:call,result: result)
            break
        case "openChatWithAnother":
            openChatWithAnother(call:call,result: result)
            break
        case "logout":
            logout()
            break
        default: result(FlutterMethodNotImplemented)
            break
        }
    }
    
    private func logout(){
        self.netAloSDK?.logout()
    }
    
    private func initChatSDK( call: FlutterMethodCall, result: @escaping FlutterResult){
        
        guard let args = call.arguments else {
            return
        }
        let argsConfig = args as! [String: Any]
        let iosConfig = argsConfig["iosConfig"] as! [String: Any]
        
        let config = NetaloConfiguration(
            enviroment: .production,
            appId: argsConfig["appId"] as! Int64,
            appKey: argsConfig["appKey"] as! String,
            accountKey: argsConfig["accountKey"] as! String,
            appGroupIdentifier: iosConfig["appGroupIdentifier"] as? String ?? "",
            storeUrl: URL(string: iosConfig["storeUrl"] as? String ?? "")!,
            deeplinkSchema: argsConfig["deeplinkSchema"] as? String ?? "",
            analytics: [],
            featureConfig: FeatureConfig(
                user: FeatureConfig.UserConfig(
                    forceUpdateProfile: iosConfig["forceUpdateProfile"] as? Bool ?? true,
                    allowCustomUsername: iosConfig["allowCustomUsername"] as? Bool ?? true,
                    allowCustomProfile: iosConfig["allowCustomProfile"] as? Bool ?? true,
                    allowCustomAlert: iosConfig["allowCustomAlert"] as? Bool ?? true,
                    allowAddContact: iosConfig["allowAddContact"] as? Bool ?? true,
                    allowBlockContact: iosConfig["allowBlockContact"] as? Bool ?? true,
                    allowSetUserProfileUrl: iosConfig["allowSetUserProfileUrl"] as? Bool ?? true,
                    allowEnableLocationFeature: iosConfig["allowEnableLocationFeature"] as? Bool ?? true,
                    allowTrackingUsingSDK: iosConfig["allowTrackingUsingSDK"] as? Bool ?? true,
                    isHiddenEditProfile: iosConfig["isHiddenEditProfile"] as? Bool ?? true,
                    allowAddNewContact: iosConfig["allowAddNewContact"] as? Bool ?? true
                    //                    allowEditContact: iosConfig["allowEditContact"] as? Bool ?? true
                ),
                chat: FeatureConfig.ChatConfig(
                    isVideoCallEnable: iosConfig["isVideoCallEnable"] as? Bool ?? true,
                    isVoiceCallEnable: iosConfig["isVoiceCallEnable"] as? Bool ?? true,
                    isHiddenSecretChat: iosConfig["isHiddenSecretChat"] as? Bool ?? true
                ),
                isSyncDataInApp: iosConfig["isSyncDataInApp"] as? Bool ?? true,
                allowReferralCode: iosConfig["allowReferralCode"] as? Bool ?? false,
                searchByLike: iosConfig["searchByLike"] as? Bool ?? true,
                allowReplaceCountrycode: iosConfig["allowReplaceCountrycode"] as? Bool ?? false,
                isSyncContactInApp: iosConfig["isSyncContactInApp"] as? Bool ?? true
            ),
            permissions:  [SDKPermissionSet.microPhone]
        )
        
        self.netAloSDK = NetAloFullManager(config: config)
        
        self.netAloSDK?
            .start()
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .catchAndReturn(())
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .do { owner, _ in
                owner.netAloSDK?.buildSDKModule()
            }
            .subscribe()
            .disposed(by: self.disposeBag)
        
        //self.initChatListener?()
        self.subject.onNext("1")
    }
    
    private func openChatConversation(){
        self.netAloSDK?.showListGroup { err in
            
        }
    }
    
    private func setUser(call: FlutterMethodCall,result: @escaping FlutterResult){
        guard let args = call.arguments else {
            return
        }
        let argsUser = args as! [String: Any]
        let user = NetAloUserHolder(id: argsUser["id"] as? Int64 ?? 0,
                                    phoneNumber:argsUser["phone"] as? String ?? "",
                                    email: "",
                                    fullName: argsUser["username"] as? String ?? "",
                                    avatarUrl: argsUser["avatar"] as? String ?? "",
                                    session: argsUser["token"] as? String ?? "")
        do {
            try self.netAloSDK?.set(user: user)
        } catch let e {
            print("Error \(e)")
        }
    }
    
    private func openChatWithAnother(call: FlutterMethodCall,result: @escaping FlutterResult){
        
        guard let args = call.arguments else {
            return
        }
        let argsUser = args as! [String: Any]
        let contact = NAContact(id: argsUser["id"] as? Int64 ?? 0,
                                phone: argsUser["phone"] as? String ?? "",
                                fullName: argsUser["username"] as? String ?? "",
                                profileUrl: argsUser["avatar"] as? String ?? "")
        do {
            self.netAloSDK?.showChat(with: contact) { err in
                result(true)
            }
        } catch let e {
            print("Error \(e)")
        }
        
        
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        print("didFinishLaunchingWithOptions")
        self.subject.subscribe(onNext: { string in
            self.netAloSDK?.application(application, didFinishLaunchingWithOptions: launchOptions as? [UIApplication.LaunchOptionsKey: Any])
            
        })
            .disposed(by: self.disposeBag)
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        self.netAloSDK?.applicationDidBecomeActive(application)
        print("applicationDidBecomeActive")
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        self.netAloSDK?.applicationWillResignActive(application)
        print("applicationWillResignActive")
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        self.netAloSDK?.applicationWillTerminate(application)
        print("applicationWillTerminate")
    }
    
    // UserActivity
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        self.netAloSDK?.application(application, continue: userActivity, restorationHandler: restorationHandler) ?? true
    }
    
    // Notification methods
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("didRegisterForRemoteNotificationsWithDeviceToken")
        self.subject.subscribe(onNext: { string in
            self.netAloSDK?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
            
        }).disposed(by: self.disposeBag)
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        self.netAloSDK?.application(application, open: url, sourceApplication: sourceApplication, annotation: application) ?? true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.netAloSDK?.application(app, open: url, options: options) ?? true
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("userNotificationCenter  willPresent")
        self.netAloSDK?.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("userNotificationCenter didReceive")
        self.netAloSDK?.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
    
}
