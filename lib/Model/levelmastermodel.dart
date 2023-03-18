class LevelMasterModel {
  LevelMasterModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory LevelMasterModel.fromJson(Map<String, dynamic> json) =>
      LevelMasterModel(
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
    this.levelOrder,
    this.levelName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? levelOrder;
  String? levelName;
  String? createdAt;
  String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        levelOrder: int.parse(json["level_order"].toString()),
        levelName: json["level_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level_order": levelOrder,
        "level_name": levelName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
