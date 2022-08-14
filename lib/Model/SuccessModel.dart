class SuccessModel {
  SuccessModel({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
