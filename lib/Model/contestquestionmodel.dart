class ContestQuestionModel {
  ContestQuestionModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory ContestQuestionModel.fromJson(Map<String, dynamic> json) =>
      ContestQuestionModel(
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
    this.categoryId,
    this.contestId,
    this.levelId,
    this.languageId,
    this.questionLevelMasterId,
    this.image,
    this.question,
    this.questionType,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.optione,
    this.answer,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? categoryId;
  int? contestId;
  int? levelId;
  int? languageId;
  int? questionLevelMasterId;
  String? image;
  String? question;
  int? questionType;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? optione;
  String? answer;
  String? note;
  String? createdAt;
  String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        //type: int.parse(json["type"].toString()),
        categoryId: int.parse(json["category_id"].toString()),
        contestId: int.parse(json["contest_id"].toString()),
        levelId: int.parse(json["level_id"].toString()),
        languageId: int.parse(json["language_id"].toString()),
        questionLevelMasterId: int.parse(json["question_level_master_id"].toString()),
        image: json["image"],
        question: json["question"],
        questionType: int.parse(json["question_type"].toString()),
        optionA: json["option_a"],
        optionB: json["option_b"],
        optionC: json["option_c"],
        optionD: json["option_d"],
        optione: json["optione"],
        answer: json["answer"],
        note: json["note"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "contest_id": contestId,
        "level_id": levelId,
        "language_id": languageId,
        "question_level_master_id": questionLevelMasterId,
        "image": image,
        "question": question,
        "question_type": questionType,
        "option_a": optionA,
        "option_b": optionB,
        "option_c": optionC,
        "option_d": optionD,
        "optione": optione,
        "answer": answer,
        "note": note,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
