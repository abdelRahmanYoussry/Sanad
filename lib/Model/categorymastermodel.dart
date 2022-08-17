class CategoryMasterModel {
  CategoryMasterModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory CategoryMasterModel.fromJson(Map<String, dynamic> json) =>
      CategoryMasterModel(
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
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
