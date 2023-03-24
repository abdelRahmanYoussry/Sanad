class PayPalModel {
  PayPalModel({
    this.status,
    this.paymentLink,
    // this.result,
  });

  int? status;
  String? paymentLink;
  // List<Result>? result;

  factory PayPalModel.fromJson(Map<String, dynamic> json) => PayPalModel(
        status: json["status"],
        paymentLink: json["payment_link"],
        // result:
        //     List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payment_link": paymentLink,
        // "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.price,
      this.name,
      this.status,
      this.coin,
      this.currencyType,
      this.idDeleted,
      this.productPackage});

  int? id;
  String? name;
  String? price;
  String? image;
  String? currencyType;
  String? coin;
  String? productPackage;
  String? status;
  String? idDeleted;
  String? createdAt;
  String? updatedAt;

  /*
               "id": 1,
            "name": "Plan 1",
            "price": "100",
            "image": "",
            "currency_type": "$",
            "coin": "1000",
            "product_package": "Product Package",
            "status": "1",
            "is_delete": "0",
            "created_at": "2022-09-27T19:47:16.000000Z",
            "updated_at": "2022-09-27T19:47:16.000000Z"
   */

  // String? optionB;
  // String? optionC;
  // String? optionD;
  // String? answer;
  // String? createdAt;
  // String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        coin: json['coin'],
        price: json['price'],
        name: json['name'],
        currencyType: json['currency_type'],
        idDeleted: json['is_delete'],
        productPackage: json['product_package'],
        status: json['status'],
        image: json["image"],
        // question: json["question"],
        // questionType: json["question_type"],
        // optionA: json["option_a"],
        // optionB: json["option_b"],
        // optionC: json["option_c"],
        // optionD: json["option_d"],
        // answer: json["answer"],
        // categoryId: json["category_id"],
        // contestId: json["contest_id"],
        // levelId: json["level_id"],
        // languageId: json["language_id"],
        // questionLevelMasterId: json["question_level_master_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        'status': status,
        'product_package': productPackage,
        'is_delete': idDeleted,
        'currency_type': currencyType,
        'name': name,
        'price': price,
        'coin': coin,
        // "category_id": categoryId,
        //     "contest_id": contestId,
        //     "level_id": levelId,
        //     "language_id": languageId,
        //     "question_level_master_id": questionLevelMasterId,
        //     "question": question,
        //     "question_type": questionType,
        //     "option_a": optionA,
        //     "option_b": optionB,
        //     "option_c": optionC,
        //     "option_d": optionD,
        //     "answer": answer,
      };
}
