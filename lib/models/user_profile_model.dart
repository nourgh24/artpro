// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  bool success;
  List<dynamic> result;
  int code;

  UserProfileModel({
    required this.success,
    required this.result,
    required this.code,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        success: json["success"],
        result: List<dynamic>.from(json["result"].map((x) => x)),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x)),
        "code": code,
      };
}

class ResultClass {
  int id;
  String name;
  dynamic userName;
  String email;
  DateTime emailVerifiedAt;
  dynamic image;
  dynamic gender;
  dynamic code;
  dynamic deviceToken;
  DateTime createdAt;
  DateTime updatedAt;

  ResultClass({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.gender,
    required this.code,
    required this.deviceToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ResultClass.fromJson(Map<String, dynamic> json) => ResultClass(
        id: json["id"],
        name: json["name"],
        userName: json["user_name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        image: json["image"],
        gender: json["gender"],
        code: json["code"],
        deviceToken: json["device_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_name": userName,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "image": image,
        "gender": gender,
        "code": code,
        "device_token": deviceToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
