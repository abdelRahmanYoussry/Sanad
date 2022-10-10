class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
    this.appId,
    this.includedSegments,
    this.data,
    this.headings,
    this.contents,
    this.bigPicture,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? appId;
  String? includedSegments;
  String? data;
  String? headings;
  String? contents;
  String? bigPicture;
  String? createdAt;
  String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        appId: json["app_id"],
        includedSegments: json["included_segments"],
        data: json["data"],
        headings: json["headings"],
        contents: json["contents"],
        bigPicture: json["big_picture"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "app_id": appId,
        "included_segments": includedSegments,
        "data": data,
        "headings": headings,
        "contents": contents,
        "big_picture": bigPicture,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
