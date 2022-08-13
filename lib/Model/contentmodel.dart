class ContentModel {
  ContentModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
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
    this.name,
    this.startDate,
    this.endDate,
    this.type,
    this.levelId,
    this.image,
    this.price,
    this.noOfUser,
    this.noOfUserPrize,
    this.noOfRank,
    this.totalPrize,
    this.prizeJson,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isBuy,
    this.isPlayed,
  });

  int? id;
  String? name;
  String? startDate;
  String? endDate;
  int? type;
  int? levelId;
  String? image;
  String? price;
  int? noOfUser;
  int? noOfUserPrize;
  int? noOfRank;
  int? totalPrize;
  String? prizeJson;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? isBuy;
  int? isPlayed;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        type: json["type"],
        levelId: json["level_id"],
        image: json["image"],
        price: json["price"],
        noOfUser: json["no_of_user"],
        noOfUserPrize: json["no_of_user_prize"],
        noOfRank: json["no_of_rank"],
        totalPrize: json["total_prize"],
        prizeJson: json["prize_json"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isBuy: json["is_buy"],
        isPlayed: json["is_played"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_date": startDate,
        "end_date": endDate,
        "type": type,
        "level_id": levelId,
        "image": image,
        "price": price,
        "no_of_user": noOfUser,
        "no_of_user_prize": noOfUserPrize,
        "no_of_rank": noOfRank,
        "total_prize": totalPrize,
        "prize_json": prizeJson,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_buy": isBuy,
        "is_played": isPlayed,
      };
}
