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
    private var netAloSDK: NetAloFullManager!
    private var disposeBag = DisposeBag()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "chat_plugin_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftChatPluginFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "initChatSDK" :
            initChatSDK(call:call,result: result)
        case "openChatConversation":
            openChatConversation()
        case "setUser" :
            setUser(call:call,result: result)
        case "openChatWithAnother":
            openChatWithAnother(call:call,result: result)
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    private func initChatSDK(call: FlutterMethodCall, result: @escaping FlutterResult){
        print("initChatSDK IOS")
        
        guard let args = call.arguments else {
            return
        }
        let argsConfig = args as! [String: Any]
        let iosConfig = argsConfig["iosConfig"] as! [String: Any]
        
        let config = NetaloConfiguration(
            enviroment: .testing,
            appId: argsConfig["appId"] as! Int64,
            appKey: argsConfig["appKey"] as! String,
            accountKey: argsConfig["accountKey"] as! String,
            appGroupIdentifier: iosConfig["appGroupIdentifier"] as? String ?? "",
            storeUrl: URL(string: iosConfig["storeUrl"] as? String ?? "https://apps.apple.com")!,
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
                    allowAddNewContact: iosConfig["allowAddNewContact"] as? Bool ?? true,
                    allowEditContact: iosConfig["allowEditContact"] as? Bool ?? true
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
        
        self.netAloSDK
            .start()
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .catchAndReturn(())
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .do { owner, _ in
                owner.netAloSDK.buildSDKModule()
            }
            .subscribe()
            .disposed(by: self.disposeBag)
    }
    
    private func openChatConversation(){
        print("openChatConversation IOS")
        self.netAloSDK.showListGroup { err in
            
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
            try self.netAloSDK.set(user: user)
        } catch let e {
            print("Error \(e)")
        }
    }
    
    private func openChatWithAnother(call: FlutterMethodCall,result: @escaping FlutterResult){
        print("openChatWithAnother IOS")
    }
}
