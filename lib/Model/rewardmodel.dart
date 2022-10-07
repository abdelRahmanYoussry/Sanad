import 'dart:convert';

RewardModel rewardModelFromJson(String str) =>
    RewardModel.fromJson(json.decode(str));

String rewardModelToJson(RewardModel data) => json.encode(data.toJson());

class RewardModel {
  RewardModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.rewardPoints,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.typename,
  });

  int? id;
  int? userId;
  String? rewardPoints;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? typename;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        rewardPoints: json["reward_points"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        typename: json["type_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "reward_points": rewardPoints,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "type_name": typename,
      };
}
