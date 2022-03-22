// ignore_for_file: file_names

class GeneralSettingModel {
  GeneralSettingModel({
    required this.status,
    required this.message,
    required this.result,
  });

  int status;
  String message;
  List<Result> result;

  factory GeneralSettingModel.fromJson(Map<String, dynamic> json) =>
      GeneralSettingModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    required this.id,
    required this.key,
    required this.value,
  });

  String id;
  String key;
  String value;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );
}
