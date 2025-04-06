
import 'package:livechat/model/user_model.dart';

class ChatListModel {
  String id;
  String message;
  String conversationToken;
  dynamic files;
  String sendTime;
  String? receivedTime;
  String? latitude;
  String? longitude;
  String? seenTime;
  String messageType;
  String userId;
  String recId;
  String createdAt;
  String updatedAt;
  UserModel userProfile;
  UserModel recProfile;

  ChatListModel({
    required this.id,
    required this.message,
    required this.conversationToken,
    required this.files,
    required this.sendTime,
    required this.receivedTime,
    required this.latitude,
    required this.longitude,
    required this.seenTime,
    required this.messageType,
    required this.userId,
    required this.recId,
    required this.createdAt,
    required this.updatedAt,
    required this.userProfile,
    required this.recProfile,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        id: json["id"].toString(),
        message: json["message"],
        conversationToken: json["conversation_token"],
        files: json["files"],
        sendTime: json["send_time"],
        receivedTime: json["received_time"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        seenTime: json["seen_time"],
        messageType: json["message_type"],
        userId: json["user_id"].toString(),
        recId: json["rec_id"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userProfile: UserModel.fromJson(json["user_profile"]),
        recProfile: UserModel.fromJson(json["rec_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "conversation_token": conversationToken,
        "files": files,
        "send_time": sendTime,
        "received_time": receivedTime,
        "latitude": latitude,
        "longitude": longitude,
        "seen_time": seenTime,
        "message_type": messageType,
        "user_id": userId,
        "rec_id": recId,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "user_profile": userProfile.toJson(),
        "rec_profile": recProfile.toJson(),
      };
}
