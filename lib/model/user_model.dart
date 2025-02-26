import 'dart:convert';

class UserModel {
  String id;
  String username;
  String email;
  String phone;
  String? avatar;
  String? firstName;
  String? lastName;
  String? about;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"].toString(),
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        about: json["about"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "username": username,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "first_name": firstName,
        "last_name": lastName,
        "about": about,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "profile_photo_url": profilePhotoUrl,
      };
}
