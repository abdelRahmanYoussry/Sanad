class StatisticsModel {
  String? message;
  List<Data>? data;

  StatisticsModel({this.message, this.data});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? contestId;
  String? totalQuestions;
  String? questionsAttended;
  String? correctAnswers;
  String? score;
  String? questionJson;
  String? date;
  String? isUnlock;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Users>? users;
  List<Contest>? contest;

  Data(
      {this.id,
      this.userId,
      this.contestId,
      this.totalQuestions,
      this.questionsAttended,
      this.correctAnswers,
      this.score,
      this.questionJson,
      this.date,
      this.isUnlock,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.users,
      this.contest});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    contestId = json['contest_id'];
    totalQuestions = json['total_questions'];
    questionsAttended = json['questions_attended'];
    correctAnswers = json['correct_answers'];
    score = json['score'];
    questionJson = json['question_json'];
    date = json['date'];
    isUnlock = json['is_unlock'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    if (json['contest'] != null) {
      contest = <Contest>[];
      json['contest'].forEach((v) {
        contest!.add(Contest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['contest_id'] = contestId;
    data['total_questions'] = totalQuestions;
    data['questions_attended'] = questionsAttended;
    data['correct_answers'] = correctAnswers;
    data['score'] = score;
    data['question_json'] = questionJson;
    data['date'] = date;
    data['is_unlock'] = isUnlock;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (contest != null) {
      data['contest'] = contest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? fullname;
  String? username;
  String? email;
  String? age;
  String? gender;
  String? country;
  String? password;
  String? mobileNumber;
  String? profileImg;
  int? type;
  String? instagramUrl;
  String? facebookUrl;
  String? twitterUrl;
  String? biodata;
  String? referenceCode;
  String? parentReferenceCode;
  int? praticeQuizScore;
  int? totalScore;
  String? totalCoins;
  String? deviceToken;
  String? status;
  int? isUpdated;
  String? cDate;
  String? createdAt;
  String? updatedAt;

  Users(
      {this.id,
      this.fullname,
      this.username,
      this.email,
      this.age,
      this.gender,
      this.country,
      this.password,
      this.mobileNumber,
      this.profileImg,
      this.type,
      this.instagramUrl,
      this.facebookUrl,
      this.twitterUrl,
      this.biodata,
      this.referenceCode,
      this.parentReferenceCode,
      this.praticeQuizScore,
      this.totalScore,
      this.totalCoins,
      this.deviceToken,
      this.status,
      this.isUpdated,
      this.cDate,
      this.createdAt,
      this.updatedAt});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    age = json['age'];
    gender = json['gender'];
    country = json['country'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
    profileImg = json['profile_img'];
    type = json['type'];
    instagramUrl = json['instagram_url'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    biodata = json['biodata'];
    referenceCode = json['reference_code'];
    parentReferenceCode = json['parent_reference_code'];
    praticeQuizScore = json['pratice_quiz_score'];
    totalScore = json['total_score'];
    totalCoins = json['total_coins'];
    deviceToken = json['device_token'];
    status = json['status'];
    isUpdated = json['is_updated'];
    cDate = json['c_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['username'] = username;
    data['email'] = email;
    data['age'] = age;
    data['gender'] = gender;
    data['country'] = country;
    data['password'] = password;
    data['mobile_number'] = mobileNumber;
    data['profile_img'] = profileImg;
    data['type'] = type;
    data['instagram_url'] = instagramUrl;
    data['facebook_url'] = facebookUrl;
    data['twitter_url'] = twitterUrl;
    data['biodata'] = biodata;
    data['reference_code'] = referenceCode;
    data['parent_reference_code'] = parentReferenceCode;
    data['pratice_quiz_score'] = praticeQuizScore;
    data['total_score'] = totalScore;
    data['total_coins'] = totalCoins;
    data['device_token'] = deviceToken;
    data['status'] = status;
    data['is_updated'] = isUpdated;
    data['c_date'] = cDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Contest {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  String? type;
  String? levelId;
  String? categoryId;
  String? category;
  String? description;
  String? image;
  String? price;
  String? priceCoins;
  String? noOfUser;
  String? noOfUserPrize;
  String? noOfRank;
  String? totalPrize;
  String? totalPrizeCoins;
  String? prizeJson;
  String? status;
  String? saveDraft;
  String? createdAt;
  String? updatedAt;

  Contest(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.type,
      this.levelId,
      this.categoryId,
      this.category,
      this.description,
      this.image,
      this.price,
      this.priceCoins,
      this.noOfUser,
      this.noOfUserPrize,
      this.noOfRank,
      this.totalPrize,
      this.totalPrizeCoins,
      this.prizeJson,
      this.status,
      this.saveDraft,
      this.createdAt,
      this.updatedAt});

  Contest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    type = json['type'];
    levelId = json['level_id'];
    categoryId = json['category_id'];
    category = json['category'];
    description = json['Description'];
    image = json['image'];
    price = json['price'];
    priceCoins = json['price_coins'];
    noOfUser = json['no_of_user'];
    noOfUserPrize = json['no_of_user_prize'];
    noOfRank = json['no_of_rank'];
    totalPrize = json['total_prize'];
    totalPrizeCoins = json['total_prize_coins'];
    prizeJson = json['prize_json'];
    status = json['status'];
    saveDraft = json['save_draft'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['type'] = type;
    data['level_id'] = levelId;
    data['category_id'] = categoryId;
    data['category'] = category;
    data['Description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['price_coins'] = priceCoins;
    data['no_of_user'] = noOfUser;
    data['no_of_user_prize'] = noOfUserPrize;
    data['no_of_rank'] = noOfRank;
    data['total_prize'] = totalPrize;
    data['total_prize_coins'] = totalPrizeCoins;
    data['prize_json'] = prizeJson;
    data['status'] = status;
    data['save_draft'] = saveDraft;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
