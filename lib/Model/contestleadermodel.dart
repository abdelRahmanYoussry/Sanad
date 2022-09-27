// To parse this JSON data, do
//
//     final contestLeaderModel = contestLeaderModelFromJson(jsonString);

import 'dart:convert';

ContestLeaderModel contestLeaderModelFromJson(String str) =>
    ContestLeaderModel.fromJson(json.decode(str));

String contestLeaderModelToJson(ContestLeaderModel data) =>
    json.encode(data.toJson());

class ContestLeaderModel {
  ContestLeaderModel({
    this.status,
    this.message,
    this.result,
    this.user,
  });

  int? status;
  String? message;
  List<Result>? result;
  List<Result>? user;

  factory ContestLeaderModel.fromJson(Map<String, dynamic> json) =>
      ContestLeaderModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        user: List<Result>.from(json["user"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.rank,
    this.id,
    this.contestId,
    this.score,
    this.userId,
    this.username,
    this.profileImg,
    this.userTotalScore,
  });

  int? rank;
  int? id;
  int? contestId;
  String? score;
  int? userId;
  String? username;
  String? profileImg;
  int? userTotalScore;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        rank: json["rank"],
        id: json["id"],
        contestId: json["contest_id"],
        score: json["score"],
        userId: json["user_id"],
        username: json["username"],
        profileImg: json["profile_img"],
        userTotalScore: json["user_total_score"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "id": id,
        "contest_id": contestId,
        "score": score,
        "user_id": userId,
        "username": username,
        "profile_img": profileImg,
        "user_total_score": userTotalScore,
      };
}
