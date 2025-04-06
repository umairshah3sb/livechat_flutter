import 'dart:convert';
class MessageModel {
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

    MessageModel({
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
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"].toString(),
        message: json["message"],
        conversationToken: json["conversation_token"],
        files: json["files"],
        sendTime: json["send_time"].toString(),
        receivedTime: json["received_time"].toString(),
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        seenTime: json["seen_time"].toString(),
        messageType: json["message_type"],
        userId: json["user_id"].toString(),
        recId: json["rec_id"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "message": message,
        "conversation_token": conversationToken,
        "files": files,
        "send_time": sendTime.toString(),
        "received_time": receivedTime.toString(),
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "seen_time": seenTime.toString(),
        "message_type": messageType,
        "user_id": userId.toString(),
        "rec_id": recId.toString(),
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
    };
}
