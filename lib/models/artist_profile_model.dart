// To parse this JSON data, do
//
//     final artistProfileModel = artistProfileModelFromJson(jsonString);

import 'dart:convert';

ArtistProfileModel artistProfileModelFromJson(String str) =>
    ArtistProfileModel.fromJson(json.decode(str));

String artistProfileModelToJson(ArtistProfileModel data) =>
    json.encode(data.toJson());

class ArtistProfileModel {
  bool success;
  List<dynamic> result;
  int code;

  ArtistProfileModel({
    required this.success,
    required this.result,
    required this.code,
  });

  factory ArtistProfileModel.fromJson(Map<String, dynamic> json) =>
      ArtistProfileModel(
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
  String expertise;
  String specialization;
  String biography;
  String gender;
  dynamic code;
  dynamic deviceToken;
  int followersNumber;
  int ratesNumber;
  DateTime createdAt;
  DateTime updatedAt;

  ResultClass({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.expertise,
    required this.specialization,
    required this.biography,
    required this.gender,
    required this.code,
    required this.deviceToken,
    required this.followersNumber,
    required this.ratesNumber,
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
        expertise: json["expertise"],
        specialization: json["specialization"],
        biography: json["biography"],
        gender: json["gender"],
        code: json["code"],
        deviceToken: json["device_token"],
        followersNumber: json["followers_number"],
        ratesNumber: json["rates_number"],
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
        "expertise": expertise,
        "specialization": specialization,
        "biography": biography,
        "gender": gender,
        "code": code,
        "device_token": deviceToken,
        "followers_number": followersNumber,
        "rates_number": ratesNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
