// ignore_for_file: file_names

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    this.result,
  });

  int status;
  String message;
  List<Result>? result;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    required this.id,
    required this.roleId,
    required this.fullname,
    required this.image,
    required this.backgroundImage,
    required this.email,
    this.password,
    required this.authToken,
    required this.mobile,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String roleId;
  String fullname;
  String image;
  String backgroundImage;
  String email;
  String? password;
  String authToken;
  String mobile;
  String type;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        roleId: json["role_id"],
        fullname: json["fullname"],
        image: json["image"],
        backgroundImage: json["background_image"],
        email: json["email"],
        password: json["password"],
        authToken: json["auth_token"],
        mobile: json["mobile"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
