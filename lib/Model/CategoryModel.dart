class CategoryModel {
  CategoryModel({
    required this.status,
    required this.message,
    required this.result,
  });

  int status;
  String message;
  List<Result> result;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String image;
  String status;
  String createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
