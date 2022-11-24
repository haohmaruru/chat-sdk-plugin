class ChatUser {
  ChatUser({
    this.id,
    this.username,
    this.avatar,
    this.phone,
    this.token,
  });

  int? id;
  String? username;
  String? avatar;
  String? phone;
  String? token;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"] ?? "",
        username: json["username"],
        avatar: json["avatar"] ?? "",
        phone: json["phone"],
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar ?? "",
        "phone": phone,
        "token": token ?? "",
      };

  bool get isEnoughBasicInfo => id != null && phone != null;
}
