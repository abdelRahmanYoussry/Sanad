class CoinsHistoryModel {
  CoinsHistoryModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory CoinsHistoryModel.fromJson(Map<String, dynamic> json) =>
      CoinsHistoryModel(
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
    this.userId,
    this.planSubscriptionId,
    this.transactionId,
    this.transactionAmount,
    this.coin,
    this.transactionDate,
    this.createdAt,
    this.updatedAt,
    this.packageName,
  });

  int? id;
  String? userId;
  String? planSubscriptionId;
  String? transactionId;
  String? transactionAmount;
  String? coin;
  String? transactionDate;
  String? createdAt;
  String? updatedAt;
  String? packageName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        planSubscriptionId: json["plan_subscription_id"],
        transactionId: json["transaction_id"],
        transactionAmount: json["transaction_amount"],
        coin: json["coin"],
        transactionDate: json["transaction_date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        packageName: json["package_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "plan_subscription_id": planSubscriptionId,
        "transaction_id": transactionId,
        "transaction_amount": transactionAmount,
        "coin": coin,
        "transaction_date": transactionDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "package_name": packageName,
      };
}
