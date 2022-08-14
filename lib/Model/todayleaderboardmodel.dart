class TodayLeaderBoardModel {
  TodayLeaderBoardModel({
    this.status,
    this.message,
    this.user,
    this.result,
  });

  int? status;
  String? message;
  User? user;
  List<User>? result;

  factory TodayLeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      TodayLeaderBoardModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        result: List<User>.from(json["result"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user!.toJson(),
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.rank,
    this.userId,
    this.score,
    this.maxScore,
    this.isUnlock,
    this.fullname,
    this.profileImg,
    this.name,
    this.userTotalScore,
    this.id,
    this.totalScore,
  });

  int? rank;
  int? userId;
  int? score;
  int? maxScore;
  int? isUnlock;
  String? fullname;
  String? profileImg;
  String? name;
  int? userTotalScore;
  int? id;
  int? totalScore;

  factory User.fromJson(Map<String, dynamic> json) => User(
        rank: json["rank"],
        userId: json["user_id"],
        score: json["score"],
        maxScore: json["max_score"],
        isUnlock: json["is_unlock"],
        fullname: json["fullname"],
        profileImg: json["profile_img"],
        name: json["name"],
        userTotalScore: json["user_total_score"],
        id: json["id"],
        totalScore: json["total_score"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "user_id": userId,
        "score": score,
        "max_score": maxScore,
        "is_unlock": isUnlock,
        "fullname": fullname,
        "profile_img": profileImg,
        "name": name,
        "user_total_score": userTotalScore,
        "id": id,
        "total_score": totalScore,
      };
}
