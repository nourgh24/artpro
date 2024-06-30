// To parse this JSON data, do
//
//     final followFromArtist = followFromArtistFromJson(jsonString);

import 'dart:convert';

FollowFromArtist followFromArtistFromJson(String str) =>
    FollowFromArtist.fromJson(json.decode(str));

String followFromArtistToJson(FollowFromArtist data) =>
    json.encode(data.toJson());

class FollowFromArtist {
  bool success;
  List<dynamic> result;
  int code;

  FollowFromArtist({
    required this.success,
    required this.result,
    required this.code,
  });

  factory FollowFromArtist.fromJson(Map<String, dynamic> json) =>
      FollowFromArtist(
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
  int followedId;
  DateTime date;
  int followerId;
  String followerType;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  ResultClass({
    required this.followedId,
    required this.date,
    required this.followerId,
    required this.followerType,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory ResultClass.fromJson(Map<String, dynamic> json) => ResultClass(
        followedId: json["followed_id"],
        date: DateTime.parse(json["date"]),
        followerId: json["follower_id"],
        followerType: json["follower_type"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "followed_id": followedId,
        "date": date.toIso8601String(),
        "follower_id": followerId,
        "follower_type": followerType,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
