// ignore_for_file: file_names

class GetLevel {
  GetLevel({
    required this.status,
    required this.result,
    required this.message,
  });

  int status;
  List<Result> result;
  String message;

  factory GetLevel.fromJson(Map<String, dynamic> json) => GetLevel(
        status: json["status"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "message": message,
      };
}

class Result {
  Result({
    required this.id,
    required this.name,
    required this.levelOrder,
    required this.score,
    required this.winQuestionCount,
    required this.totalQuestion,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.categoryId,
    required this.isUnlock,
  });

  String id;
  String name;
  String levelOrder;
  String score;
  String winQuestionCount;
  String totalQuestion;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  String categoryId;
  int isUnlock;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        levelOrder: json["level_order"],
        score: json["score"],
        winQuestionCount: json["win_question_count"],
        totalQuestion: json["total_question"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        categoryId: json["category_id"],
        isUnlock: json["is_unlock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level_order": levelOrder,
        "score": score,
        "win_question_count": winQuestionCount,
        "total_question": totalQuestion,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "category_id": categoryId,
        "is_unlock": isUnlock,
      };
}
