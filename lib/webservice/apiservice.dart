import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/model/categorymastermodel.dart';
import 'package:quizapp/model/categorymodel.dart';
import 'package:quizapp/model/contentmodel.dart';
import 'package:quizapp/model/contestquestionmodel.dart';
import 'package:quizapp/model/earnmodel.dart';
import 'package:quizapp/model/generalsettingmodel.dart';
import 'package:quizapp/model/levelmastermodel.dart';
import 'package:quizapp/model/levelmodel.dart';
import 'package:quizapp/model/levelpraticemodel.dart';
import 'package:quizapp/model/loginmodel.dart';
import 'package:quizapp/model/packagesmodel.dart';
import 'package:quizapp/model/praticeleaderboardmodel.dart';
import 'package:quizapp/model/profilemodel.dart';
import 'package:quizapp/model/questionmodel.dart';
import 'package:quizapp/model/questionpraticemodel.dart';
import 'package:quizapp/model/refertranmodel.dart';
import 'package:quizapp/model/registrationmodel.dart';
import 'package:quizapp/model/rewardmodel.dart';
import 'package:quizapp/model/successmodel.dart';
import 'package:quizapp/model/todayleaderboardmodel.dart';
import 'package:quizapp/model/winnermodel.dart';
import 'package:quizapp/utils/constant.dart';
import 'package:path/path.dart';
import '../model/contestleadermodel.dart';
import '../model/leaderboardmodel.dart';

class ApiService {
  String baseurl = Constant().baseurl;
  late Dio dio;

  ApiService() {
    dio = Dio();
  }

  Future<GeneralSettingModel> genaralSetting() async {
    GeneralSettingModel generalSettingModel;
    String generalsetting = "general_setting";
    Response response = await dio.post('$baseurl$generalsetting');
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("generalsetting apiservice:===>${response.data}");
      generalSettingModel = GeneralSettingModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return generalSettingModel;
  }

  Future<LoginModel> login(String email, String username, String profileImg,
      String pass, String type, String devicetoken) async {
    LoginModel loginmodel;
    String login = "login";
    Response response = await dio.post('$baseurl$login',
        data: ({
          'email': email,
          'username': username,
          'profile_img': profileImg,
          'password': pass,
          'type': type,
          'device_token': devicetoken
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Login apiservice:===>${response.data}");
      loginmodel = LoginModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return loginmodel;
  }

  Future<LoginModel> loginwithotp(mobile) async {
    LoginModel loginmodel;
    String login = "loginwithotp";
    Response response = await dio.post('$baseurl$login',
        data: FormData.fromMap({
          'mobile_number': mobile,
        }));
    if (response.statusCode == 200) {
      loginmodel = LoginModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load album');
    }
    return loginmodel;
  }

  Future<SuccessModel> forgotpassword(String email) async {
    SuccessModel successModel;
    String login = "forgot_password";
    Response response =
        await dio.post('$baseurl$login', data: ({'email': email}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("ForgotPassword apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<RegistrationModel> registration(
      String email,
      String pass,
      String firstname,
      String lastname,
      String mobilenumber,
      String refercode,
      String fullname,
      String username) async {
    RegistrationModel registrationModel;
    String registration = "registration";
    Response response = await dio.post('$baseurl$registration',
        data: ({
          'email': email,
          'password': pass,
          'first_name': firstname,
          'last_name': lastname,
          'mobile_number': mobilenumber,
          'parent_reference_code': refercode,
          'fullname': fullname,
          'username': username
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("generalsetting apiservice:===>${response.data}");
      registrationModel = RegistrationModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return registrationModel;
  }

  Future<CategoryModel> category() async {
    CategoryModel categoryModel;
    String category = "get_category";
    Response response = await dio.post('$baseurl$category');
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Category apiservice:===>${response.data}");
      categoryModel = CategoryModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return categoryModel;
  }

  Future<LevelModel> level(String catId, String userId) async {
    LevelModel levelModel;
    String level = "get_level";
    Response response = await dio.post('$baseurl$level',
        data: ({'category_id': catId, 'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("level apiservice:===>${response.data}");
      levelModel = LevelModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return levelModel;
  }

  Future<QuestionModel> questionByLevel(String catId, String levelId) async {
    QuestionModel questionModel;
    String level = "question_by_level";
    Response response = await dio.post('$baseurl$level',
        data: ({'category_id': catId, 'level_id': levelId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Question apiservice:===>${response.data}");
      questionModel = QuestionModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return questionModel;
  }

  Future<ProfileModel> profile(String userId) async {
    ProfileModel profileModel;
    String profile = "profile";
    Response response =
        await dio.post('$baseurl$profile', data: ({'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Profile apiservice:===>${response.data}");
      profileModel = ProfileModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return profileModel;
  }

  Future<SuccessModel> updateProfile(
      userId, fullname, email, contact, address, image) async {
    SuccessModel successModel;
    String profile = "update_profile";
    Response response = await dio.post('$baseurl$profile',
        data: FormData.fromMap({
          'user_id': userId,
          "fullname": fullname,
          "email": email,
          "mobile_number": contact,
          "biodata": address,
          "profile_img": await MultipartFile.fromFile(image.path,
              filename: basename(image.path))
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Profile apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<ReferTranModel> referTran(String userId) async {
    ReferTranModel referTranModel;
    String profile = "refer_transaction";
    Response response =
        await dio.post('$baseurl$profile', data: ({'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Refer apiservice:===>${response.data}");
      referTranModel = ReferTranModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return referTranModel;
  }

  Future<EarnModel> earnpoints(String userId) async {
    EarnModel earnModel;
    String profile = "get_earn_transaction";
    Response response =
        await dio.post('$baseurl$profile', data: ({'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Earn apiservice:===>${response.data}");
      earnModel = EarnModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return earnModel;
  }

  Future<RewardModel> rewardpoints(String userId) async {
    RewardModel rewardModel;
    String profile = "get_reward_points";
    Response response =
        await dio.post('$baseurl$profile', data: ({'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Refer apiservice:===>${response.data}");
      rewardModel = RewardModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return rewardModel;
  }

  Future<ContentModel> getContest(String listType, String userId) async {
    ContentModel contentModel;
    String content = "getContest";
    Response response = await dio.post('$baseurl$content',
        data: ({'list_type': listType, 'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("getContest apiservice:===>${response.data}");
      contentModel = ContentModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return contentModel;
  }

  Future<SuccessModel> joinContest(
      String contestId, String userId, String coin) async {
    SuccessModel successModel;
    String content = "joinContest";
    Response response = await dio.post('$baseurl$content',
        data: ({'contest_id': contestId, 'user_id': userId, 'coin': coin}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("joinContest apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<ContestLeaderModel> contestleaderBoard(
      String userId, int contestId) async {
    ContestLeaderModel contestLeaderModel;
    String contestleaderboard = "getContestLeaderBoard";
    Response response = await dio.post('$baseurl$contestleaderboard',
        data: ({'user_id': userId, 'contest_id': contestId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Contest leaderBoard apiservice:===>${response.data}");
      contestLeaderModel = ContestLeaderModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return contestLeaderModel;
  }

  Future<WinnerModel> winnerbycontest(String contestId) async {
    WinnerModel winnerModel;
    String content = "get_winner_by_contest";
    Response response = await dio.post('$baseurl$content',
        data: ({
          'contest_id': contestId,
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("winnerModel apiservice:===>${response.data}");
      winnerModel = WinnerModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return winnerModel;
  }

  Future<ContestQuestionModel> questionByContest(String contestId) async {
    ContestQuestionModel contestQuestionModel;
    String level = "question_by_contest";
    Response response =
        await dio.post('$baseurl$level', data: ({'contest_id': contestId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Question apiservice:===>${response.data}");
      contestQuestionModel = ContestQuestionModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return contestQuestionModel;
  }

  Future<SuccessModel> saveQuestionReport(
      String levelId,
      String questionsAttended,
      String totalQuestion,
      String correctAnswers,
      String userId,
      String categoryId) async {
    SuccessModel successModel;
    String content = "save_question_report";
    Response response = await dio.post('$baseurl$content',
        data: ({
          'level_id': levelId,
          'user_id': userId,
          'questions_attended': questionsAttended,
          'total_question': totalQuestion,
          'correct_answers': correctAnswers,
          'user_id': userId,
          'category_id': categoryId
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Save Question apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<SuccessModel> saveContestQuestionReport(
      String contestId,
      String questionsAttended,
      String totalQuestion,
      String correctAnswers,
      String userId,
      String questionJson) async {
    SuccessModel successModel;
    String content = "save_contest_question_report";
    Response response = await dio.post('$baseurl$content',
        data: ({
          'contest_id': contestId,
          'user_id': userId,
          'questions_attended': questionsAttended,
          'total_questions': totalQuestion,
          'correct_answers': correctAnswers,
          'question_json': questionJson
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Save Contest Question apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<TodayLeaderBoardModel> todayLeaderBoard(
      String userId, String levelId) async {
    TodayLeaderBoardModel todayLeaderBoardModel;
    String leaderboard = "getTodayLeaderBoard";
    Response response = await dio.post('$baseurl$leaderboard',
        data: ({'user_id': userId, 'level_id': levelId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("TodayLeaderBoard apiservice:===>${response.data}");
      todayLeaderBoardModel = TodayLeaderBoardModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return todayLeaderBoardModel;
  }

  Future<LeaderBoardModel> leaderBoard(String userId, String type) async {
    LeaderBoardModel leaderBoardModel;
    String leaderboard = "getLeaderBoard";
    Response response = await dio.post('$baseurl$leaderboard',
        data: ({'user_id': userId, 'type': type}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("leaderBoard apiservice:===>${response.data}");
      leaderBoardModel = LeaderBoardModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return leaderBoardModel;
  }

  Future<LevelMasterModel> questionLevelMaster() async {
    LevelMasterModel levelMasterModel;
    String level = "getQuestionLevelMaster";
    Response response = await dio.post('$baseurl$level');
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Question level apiservice:===>${response.data}");
      levelMasterModel = LevelMasterModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return levelMasterModel;
  }

  Future<CategoryMasterModel> categoryByLevelMaster(String masterId) async {
    CategoryMasterModel categoryMasterModel;
    String category = "getCategoryByLevelMaster";
    Response response = await dio.post('$baseurl$category',
        data: ({
          'question_level_master_id': masterId,
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("categoryMasterModel apiservice:===>${response.data}");
      categoryMasterModel = CategoryMasterModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return categoryMasterModel;
  }

  Future<LevelPraticeModel> practiceLavelByCategoryId(
      String catId, String userId) async {
    LevelPraticeModel levelPraticeModel;
    String level = "getPracticeLavelByCategoryId";
    Response response = await dio.post('$baseurl$level',
        data: ({'category_id': catId, 'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("levelpratice apiservice:===>${response.data}");
      levelPraticeModel = LevelPraticeModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return levelPraticeModel;
  }

  Future<QuestionPraticeModel> practiceQuestionByLavel(
      String catId, String levelId, String levelMasterId) async {
    QuestionPraticeModel questionPraticeModel;
    String level = "getPracticeQuestionByLavel";
    Response response = await dio.post('$baseurl$level',
        data: ({
          'category_id': catId,
          'level_id': levelId,
          'question_level_master_id': levelMasterId
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Question apiservice:===>${response.data}");
      questionPraticeModel = QuestionPraticeModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return questionPraticeModel;
  }

  Future<SuccessModel> savePraticeQuestionReport(
    String userId,
    String masterId,
    String categoryId,
    String levelId,
    String totalQuestion,
    String questionsAttended,
    String correctAnswers,
  ) async {
    SuccessModel successModel;
    String content = "save_Practice_Question_Report";
    Response response = await dio.post('$baseurl$content',
        data: ({
          'user_id': userId,
          'question_level_master_id': masterId,
          'category_id': categoryId,
          'level_id': levelId,
          'total_question': totalQuestion,
          'questions_attended': questionsAttended,
          'correct_answers': correctAnswers,
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("Save Question apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<PraticeLeaderboardModel> practiseLeaderBoard(String userId) async {
    PraticeLeaderboardModel praticeLeaderboardModel;
    String leaderboard = "getPractiseLeaderBoard";
    Response response =
        await dio.post('$baseurl$leaderboard', data: ({'user_id': userId}));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("PraticeLeaderBoard apiservice:===>${response.data}");
      praticeLeaderboardModel =
          PraticeLeaderboardModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return praticeLeaderboardModel;
  }

  Future<PackagesModel> packages() async {
    PackagesModel packagesModel;
    String profile = "get_packages";
    Response response = await dio.get('$baseurl$profile');
    if (response.statusCode == 200) {
      debugPrint("Package apiservice:===>${response.data}");
      packagesModel = PackagesModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return packagesModel;
  }

  Future<SuccessModel> addTransacation(
      String userId, String planId, String amount, String coin) async {
    SuccessModel successModel;
    String content = "add_transaction";
    Response response = await dio.post('$baseurl$content',
        data: ({
          'user_id': userId,
          'plan_subscription_id': planId,
          'transaction_amount': amount,
          'coin': coin
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("add_transaction apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }
}
