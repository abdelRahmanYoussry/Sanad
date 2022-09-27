import 'dart:convert';

WinnerModel winnerModelFromJson(String str) =>
    WinnerModel.fromJson(json.decode(str));

String winnerModelToJson(WinnerModel data) => json.encode(data.toJson());

class WinnerModel {
  WinnerModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory WinnerModel.fromJson(Map<String, dynamic> json) => WinnerModel(
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
    this.contestId,
    this.rank,
    this.price,
    this.score,
    this.percentage,
    this.createdAt,
    this.updatedAt,
    this.fullname,
  });

  int? id;
  int? userId;
  int? contestId;
  int? rank;
  int? price;
  String? score;
  String? percentage;
  String? createdAt;
  String? updatedAt;
  String? fullname;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        contestId: json["contest_id"],
        rank: json["rank"],
        price: json["price"],
        score: json["score"],
        percentage: json["percentage"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "contest_id": contestId,
        "rank": rank,
        "price": price,
        "score": score,
        "percentage": percentage,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "fullname": fullname,
      };
}
