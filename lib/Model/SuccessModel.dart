// ignore_for_file: file_names

class SuccessModel {
  SuccessModel({
    required this.status,
    required this.message,
  });

  int status;
  String message;

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        status: json["status"],
        message: json["message"],
      );
}
