package vn.asia.chat_plugin_flutter

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.asia.sdkcore.config.Environment
import com.asia.sdkcore.model.sdk.*
import com.asia.sdkcore.model.ui.user.NeUser
import com.asia.sdkui.sdk.ChatSDK
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

/** ChatPluginFlutterPlugin */
class ChatPluginFlutterPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "chat_plugin_flutter")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "initChatSDK" -> initChatSDK(call, result)
            "openChatConversation" -> openChatConversation()
            "setUser" -> setUser(call, result)
            "openChatWithAnother" -> openChatWithAnother(call, result)
            else -> result.notImplemented()
        }
    }

    private fun setUser(call: MethodCall, result: Result) {
        ChatSDK.setUserSDK(
            NeUser(
                id = call.argument("id") as? Long ?: 0,
                token = call.argument("token") as? String ?: "",
                username = call.argument("username") ?: "",
                avatar = call.argument("avatar") as? String ?: "",
                phone = call.argument("phone") as? String ?: ""
            )
        )
    }

    private fun openChatConversation() {
        GlobalScope.launch(Dispatchers.Main) {
            ChatSDK.openListConversationSDK()
        }

    }

    private fun openChatWithAnother(call: MethodCall, result: Result) {
        GlobalScope.launch(Dispatchers.Main) {
            ChatSDK.openChatSDK(
                NeUser(
                    id = call.argument("id") as? Long ?: 0,
                    username = call.argument("username") ?: "",
                    avatar = call.argument("avatar") as? String ?: "",
                    phone = call.argument("phone") as? String ?: ""
                )
            )
        }
    }

    private fun initChatSDK(@NonNull call: MethodCall, @NonNull result: Result) {
        //val targetUser: HashMap<String, Any> = call.argument("targetUser")!!
        var config: SDKConfig? = SDKConfig()
        var theme: SDKTheme? = SDKTheme()
        var setting: SDKSetting? = SDKSetting()

        val args = call.arguments
        Log.e("initChatSDK", args.toString())

        val appId = call.argument("appId") as? Int ?: 0
        val appKey = call.argument("appKey") as? String ?: ""
        val accountKey = call.argument("accountKey") as? String ?: ""

        val androidConfig: HashMap<String, Any>? = call.argument("androidConfig")
        androidConfig?.let { androidConfig ->
            config = SDKConfig(
                classMainActivity = androidConfig["classMainActivity"] as? String,
                isSyncContact = androidConfig["isSyncContact"] as? Boolean ?: false,
                hidePhone = androidConfig["hidePhone"] as? Boolean ?: false,
                hideCreateGroup = androidConfig["hideCreateGroup"] as? Boolean ?: false,
                hideAddInfoInChat = androidConfig["hideAddInfoInChat"] as? Boolean ?: false,
                hideCallInChat = androidConfig["hideCallInChat"] as? Boolean ?: false,
            )
            val androidTheme: HashMap<String, Any>? = androidConfig["androidTheme"] as? HashMap<String, Any>
            androidTheme?.let { androidTheme ->
                theme = SDKTheme(
                    mainColor = androidTheme["mainColor"] as? String,
                    toolbarColor = androidTheme["toolbarColor"] as? String,
                    toolbarDrawable = androidTheme["toolbarDrawable"] as? Int,
                )
            }

            val androidSetting: HashMap<String, Any>? = androidConfig["androidSetting"] as? HashMap<String, Any>
            androidSetting?.let { androidSetting ->
                setting = SDKSetting(
                    apiEndpoint = androidSetting["apiEndpoint"] as? String,
                    cdnEndpoint = androidSetting["cdnEndpoint"] as? String,
                    chatEndpoint = androidSetting["chatEndpoint"] as? String,
                    turnServerEndpoint = androidSetting["turnServerEndpoint"] as? String,
                )

            }
        }

        ChatSDK.initSDK(
            context = context,
            sdkInit = SDKInit(
                key = SDKKey(
                    appId = appId,
                    appKey = appKey,
                    accountKey = accountKey
                ),
                theme = theme,
                config = config,
                setting = setting
            )
        )
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
