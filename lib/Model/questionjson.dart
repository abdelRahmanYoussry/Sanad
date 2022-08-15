class QuestionJson {
  String? id;
  String? userAnswer;
  QuestionJson(this.id, this.userAnswer);
  Map toJson() => {
        'id': id,
        'user_answer': userAnswer,
      };
}
