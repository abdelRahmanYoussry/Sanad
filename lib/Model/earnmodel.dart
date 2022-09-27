class EarnModel {
  EarnModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory EarnModel.fromJson(Map<String, dynamic> json) => EarnModel(
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
    this.type,
    this.point,
    this.createdAt,
    this.contestName,
  });

  int? id;
  int? userId;
  int? contestId;
  int? type;
  String? point;
  String? createdAt;
  String? contestName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        contestId: json["contest_id"],
        type: json["type"],
        point: json["point"],
        createdAt: json["created_at"],
        contestName: json["contest_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "contest_id": contestId,
        "type": type,
        "point": point,
        "created_at": createdAt,
        "contest_name": contestName,
      };
}
