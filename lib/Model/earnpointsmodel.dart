class EarnPointsModel {
  EarnPointsModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory EarnPointsModel.fromJson(Map<String, dynamic> json) =>
      EarnPointsModel(
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
    this.spinWheel,
    this.dailyLogin,
    this.freeCoin,
  });

  List<DailyLogin>? spinWheel;
  List<DailyLogin>? dailyLogin;
  List<DailyLogin>? freeCoin;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        spinWheel: List<DailyLogin>.from(
            json["spin_wheel"].map((x) => DailyLogin.fromJson(x))),
        dailyLogin: List<DailyLogin>.from(
            json["daily_login"].map((x) => DailyLogin.fromJson(x))),
        freeCoin: List<DailyLogin>.from(
            json["free_coin"].map((x) => DailyLogin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spin_wheel": List<dynamic>.from(spinWheel!.map((x) => x.toJson())),
        "daily_login": List<dynamic>.from(dailyLogin!.map((x) => x.toJson())),
        "free_coin": List<dynamic>.from(freeCoin!.map((x) => x.toJson())),
      };
}

class DailyLogin {
  DailyLogin({
    this.id,
    this.key,
    this.value,
    this.type,
    this.pointType,
    this.createdAt,
  });

  int? id;
  String? key;
  String? value;
  int? type;
  int? pointType;
  String? createdAt;

  factory DailyLogin.fromJson(Map<String, dynamic> json) => DailyLogin(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        type: json["type"],
        pointType: json["point_type"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "type": type,
        "point_type": pointType,
        "created_at": createdAt,
      };
}
