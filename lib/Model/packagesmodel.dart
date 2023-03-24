class PackagesModel {
  PackagesModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
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
    this.price,
    this.image,
    this.currencyType,
    this.coin,
    this.productPackage,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isDelete,
  });

  int? id;
  String? name;
  String? price;
  String? image;
  String? currencyType;
  String? coin;
  String? productPackage;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? isDelete;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        currencyType: json["currency_type"],
        coin: json["coin"],
        productPackage: json["product_package"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isDelete: json["is_delete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "currency_type": currencyType,
        "coin": coin,
        "product_package": productPackage,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_delete": isDelete,
      };
}
