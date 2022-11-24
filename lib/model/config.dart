class HuraConfig {
  int appId;
  String appKey;
  String accountKey;
  AndroidConfig? androidConfig;
  IosConfig? iosConfig;
  // int? environment;
  HuraConfig({
    required this.appId,
    required this.appKey,
    required this.accountKey,
    // this.environment = Environment.dev,
    this.androidConfig,
    this.iosConfig,
  }) {
    androidConfig ??= AndroidConfig();
    iosConfig ??= IosConfig();
  }

  Map<String, dynamic> toJson() => {
        "appId": appId,
        "appKey": appKey,
        "accountKey": accountKey,
        // "environment": environment,
        "androidConfig": androidConfig?.toJson(),
        "iosConfig": iosConfig?.toJson()
      };
}

class AndroidConfig {
  String? classMainActivity;
  bool? isSyncContact;
  bool? hidePhone;
  bool? hideCreateGroup;
  bool? hideAddInfoInChat;
  bool? hideInfoInChat;
  bool? hideCallInChat;

  AndroidTheme? androidTheme;
  AndroidSetting? androidSetting;
  AndroidConfig({
    this.classMainActivity,
    this.isSyncContact = false,
    this.hidePhone = true,
    this.hideCreateGroup = false,
    this.hideAddInfoInChat = false,
    this.hideInfoInChat = false,
    this.androidTheme,
    this.androidSetting,
  }) {
    androidTheme ??= AndroidTheme();
  }

  Map<String, dynamic> toJson() => {
        "classMainActivity": classMainActivity,
        "isSyncContact": isSyncContact,
        "hidePhone": hidePhone,
        "hideCreateGroup": hideCreateGroup,
        "hideAddInfoInChat": hideAddInfoInChat,
        "hideCallInChat": hideCallInChat,
        "androidTheme": androidTheme?.toJson(),
        "androidSetting": androidSetting?.toJson(),
      };
}

class AndroidTheme {
  String? mainColor;
  String? toolbarColor;
  String? toolbarDrawable;
  AndroidTheme({
    this.mainColor = "#9c5aff",
    this.toolbarColor = "#ebdeff",
    this.toolbarDrawable,
  });

  Map<String, dynamic> toJson() => {
        "mainColor": mainColor,
        "toolbarColor": toolbarColor,
        "toolbarDrawable": toolbarDrawable,
      };
}

class AndroidSetting {
  String? apiEndpoint;
  String? cdnEndpoint;
  String? chatEndpoint;
  String? turnServerEndpoint;

  AndroidSetting({
    this.apiEndpoint,
    this.cdnEndpoint,
    this.chatEndpoint,
    this.turnServerEndpoint,
  });

  Map<String, dynamic> toJson() => {
        "apiEndpoint": apiEndpoint,
        "cdnEndpoint": cdnEndpoint,
        "chatEndpoint": chatEndpoint,
        "turnServerEndpoint": turnServerEndpoint,
      };
}

class IosConfig {
  String? appGroupIdentifier;
  bool? allowCustomUsername;
  bool? allowCustomProfile;
  bool? allowCustomAlert;
  bool? allowAddContact;
  bool? allowBlockContact;
  bool? allowSetUserProfileUrl;
  bool? allowEnableLocationFeature;

  IosConfig({
    this.appGroupIdentifier,
    this.allowCustomUsername = true,
    this.allowCustomProfile = true,
    this.allowCustomAlert = true,
    this.allowAddContact = true,
    this.allowBlockContact = true,
    this.allowSetUserProfileUrl = true,
    this.allowEnableLocationFeature = true,
  });
  Map<String, dynamic> toJson() => {
        "appGroupIdentifier": appGroupIdentifier,
        "allowCustomUsername": allowCustomUsername,
        "allowCustomProfile": allowCustomProfile,
        "allowCustomAlert": allowCustomAlert,
        "allowAddContact": allowAddContact,
        "allowBlockContact": allowBlockContact,
        "allowSetUserProfileUrl": allowSetUserProfileUrl,
        "allowEnableLocationFeature": allowEnableLocationFeature,
      };
}
