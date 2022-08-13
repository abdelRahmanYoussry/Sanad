class ReferTranModel {
  ReferTranModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory ReferTranModel.fromJson(Map<String, dynamic> json) => ReferTranModel(
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
    this.referedPoint,
    this.referedDate,
    this.referenceCode,
    this.userName,
    this.email,
    this.profileImg,
    this.mobileNumber,
  });

  int? referedPoint;
  String? referedDate;
  int? referenceCode;
  String? userName;
  String? email;
  String? profileImg;
  String? mobileNumber;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        referedPoint: json["refered_point"],
        referedDate: json["refered_date"],
        referenceCode: json["reference_code"],
        userName: json["user_name"],
        email: json["email"],
        profileImg: json["profile_img"],
        mobileNumber: json["mobile_number"],
      );

  Map<String, dynamic> toJson() => {
        "refered_point": referedPoint,
        "refered_date": referedDate,
        "reference_code": referenceCode,
        "user_name": userName,
        "email": email,
        "profile_img": profileImg,
        "mobile_number": mobileNumber,
      };
}
