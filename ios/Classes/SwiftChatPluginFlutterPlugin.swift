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
    private lazy var mainWindow = UIWindow(frame: UIScreen.main.bounds)
    private var netAloFull: NetAloFullManager!
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
        
        //        var config = NetaloConfiguration(
        //            enviroment: .production,
        //            appId: 1,
        //            appKey: "appKey",
        //            accountKey: "adminkey",
        //            appGroupIdentifier: "group.vn.netacom.hura",
        //            mailSupport: "",
        //            analytics: [],
        //            featureConfig: FeatureConfig(
        //                user: FeatureConfig.UserConfig(
        //                    forceUpdateProfile : true,
        //                    allowCustomUsername: true,
        //                    allowCustomProfile : true,
        //                    allowCustomAlert   : true,
        //                    allowAddContact    : false,
        //                    allowBlockContact  : true,
        //                    allowSetUserProfileUrl   : true,
        //                    allowEnableLocationFeature: true,
        //                    allowTrackingUsingSDK: true,
        //                    allowTrackingBadgeNumber: true,
        //                    allowRecieverChatInOA: false
        //                ),
        //                chat: FeatureConfig.ChatConfig(isVideoCallEnable: false,
        //                                               isVoiceCallEnable: false),
        //                isSyncDataInApp: true
        //            ), userProfileUrl: "https://npyqgw0eplobj.vcdn.cloud"
        //        )
        
        var config = NetaloConfiguration(
            enviroment: .development,
            appId: 1,
            appKey: "appKey",
            accountKey: "adminkey",
            appGroupIdentifier: "group.vn.netacom.hura",
            storeUrl: URL(string: "https://apps.apple.com/vn/app/vndirect/id1594533471")!,
            analytics: [],
            featureConfig: FeatureConfig(
                user: FeatureConfig.UserConfig(
                    forceUpdateProfile: true,
                    allowCustomUsername: true,
                    allowCustomProfile: true,
                    allowCustomAlert: true,
                    allowAddContact: true,
                    allowBlockContact: true,
                    allowSetUserProfileUrl: true,
                    allowEnableLocationFeature: true,
                    allowTrackingUsingSDK: true,
                    isHiddenEditProfile: true,
                    allowAddNewContact: true,
                    allowEditContact: true
                ),
                chat: FeatureConfig.ChatConfig(
                    isVideoCallEnable: true,
                    isVoiceCallEnable: true,
                    isHiddenSecretChat: true
                ),
                isSyncDataInApp: true,
                allowReferralCode: false,
                searchByLike: true,
                allowReplaceCountrycode: false,
                isSyncContactInApp: true
            ),
            permissions:  [SDKPermissionSet.microPhone]
        )
        
        self.netAloFull = NetAloFull(config: config)
        
        self.netAloFull
            .start()
            .timeout(.seconds(10), scheduler: MainScheduler.instance)
            .catchAndReturn(())
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .do(onNext: { (owner, _) in
                // Init rooter
                owner.netAloFull.buildSDKModule()
            })
                .subscribe()
                .disposed(by: disposeBag)
                
                }
    
    private func openChatConversation(){
        print("openChatConversation IOS")
        self.netAloFull.showListGroup { err in
            
        }
    }
    
    private func setUser(call: FlutterMethodCall,result: @escaping FlutterResult){
        print("setUser IOS")
    }
    
    private func openChatWithAnother(call: FlutterMethodCall,result: @escaping FlutterResult){
        print("openChatWithAnother IOS")
    }
}
