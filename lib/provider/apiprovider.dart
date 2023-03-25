import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sanad/model/categorymastermodel.dart';
import 'package:sanad/model/categorymodel.dart';
import 'package:sanad/model/coinshistorymodel.dart';
import 'package:sanad/model/contentmodel.dart';
import 'package:sanad/model/contestleadermodel.dart';
import 'package:sanad/model/contestquestionmodel.dart';
import 'package:sanad/model/earnmodel.dart';
import 'package:sanad/model/earnpointsmodel.dart';
import 'package:sanad/model/generalsettingmodel.dart';
import 'package:sanad/model/leaderboardmodel.dart';
import 'package:sanad/model/levelmastermodel.dart';
import 'package:sanad/model/levelmodel.dart';
import 'package:sanad/model/levelpraticemodel.dart';
import 'package:sanad/model/loginmodel.dart';
import 'package:sanad/model/notificationmodel.dart';
import 'package:sanad/model/packagesmodel.dart';
import 'package:sanad/model/praticeleaderboardmodel.dart';
import 'package:sanad/model/profilemodel.dart';
import 'package:sanad/model/questionmodel.dart';
import 'package:sanad/model/questionpraticemodel.dart';
import 'package:sanad/model/refertranmodel.dart';
import 'package:sanad/model/registrationmodel.dart';
import 'package:sanad/model/rewardmodel.dart';
import 'package:sanad/model/successmodel.dart';
import 'package:sanad/model/todayleaderboardmodel.dart';
import 'package:sanad/model/winnermodel.dart';
import 'package:sanad/webservice/apiservice.dart';

class ApiProvider extends ChangeNotifier {
  GeneralSettingModel generalSettingModel = GeneralSettingModel();

  LoginModel loginModel = LoginModel();

  RegistrationModel registrationModel = RegistrationModel();

  CategoryModel categoryModel = CategoryModel();

  LevelModel levelModel = LevelModel();

  QuestionModel questionModel = QuestionModel();
  ContestQuestionModel contestQuestionModel = ContestQuestionModel();

  ContentModel upcontentModel = ContentModel();
  ContentModel livecontentModel = ContentModel();
  ContentModel endcontentModel = ContentModel();
  ContestLeaderModel contestLeaderModel = ContestLeaderModel();
  WinnerModel winnerModel = WinnerModel();

  ProfileModel profileModel = ProfileModel();

  ReferTranModel referTranModel = ReferTranModel();
  RewardModel rewardModel = RewardModel();
  CoinsHistoryModel coinsHistoryModel = CoinsHistoryModel();
  EarnModel earnModel = EarnModel();
  SuccessModel successModel = SuccessModel();
  TodayLeaderBoardModel todayLeaderBoardModel = TodayLeaderBoardModel();
  LeaderBoardModel leaderBoardModel = LeaderBoardModel();

  LevelMasterModel levelMasterModel = LevelMasterModel();
  CategoryMasterModel categoryMasterModel = CategoryMasterModel();
  LevelPraticeModel levelPraticeModel = LevelPraticeModel();

  QuestionPraticeModel questionPraticeModel = QuestionPraticeModel();
  PraticeLeaderboardModel praticeLeaderboardModel = PraticeLeaderboardModel();
  PackagesModel packagesModel = PackagesModel();
  NotificationModel notificationModel = NotificationModel();
  EarnPointsModel earnPointsModel = EarnPointsModel();

  bool loading = false;
  String? email, password, type, deviceToken;

  String? firstname, lastname, mobilenumber, fullname, username;

  String? catId;

  int? selectQuestion = 0;

  getGeneralsetting(context) async {
    loading = true;
    generalSettingModel = await ApiService().genaralSetting();
    // // debugPrint("${generalSettingModel.status}");
    loading = false;
    notifyListeners();
  }

  login(
      context, email, username, profileImg, password, type, deviceToken) async {
    loading = true;
    loginModel = await ApiService()
        .login(email, username, profileImg, password, type, deviceToken);
    // // debugPrint("${loginModel.status}");
    loading = false;
    notifyListeners();
  }

  loginwithotp(mobile) async {
    loading = false;
    loginModel = await ApiService().loginwithotp(mobile);
    // // debugPrint("login status :== ${loginModel.status}");
    loading = true;
    notifyListeners();
  }

  registration(
      {context,
      email,
      password,
      firstname,
      lastname,
      mobilenumber,
      refercode,
      fullname,
      username,
      age,
      gender,
      country}
      //  {required BuildContext context,
      // required String email, required String password,required String firstName,
      //  }
      ) async {
    loading = true;
    // // debugPrint('====>$mobilenumber');
    registrationModel = await ApiService().registration(
        age: age,
        email: email,
        firstname: firstname,
        fullname: fullname,
        gender: gender,
        lastname: lastname,
        mobilenumber: mobilenumber,
        pass: password,
        refercode: refercode,
        username: username,
        country: country
        // email,
        // password,
        // firstname,
        // lastname,
        // mobilenumber,
        // refercode,
        // fullname,
        // username,
        // gender,
        // age
        );
    // // debugPrint("${registrationModel.status}");
    loading = false;
    notifyListeners();
  }

  forgotPassword(email) async {
    loading = true;
    successModel = await ApiService().forgotpassword(email);
    // // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getProfile(context, userId) async {
    loading = true;
    profileModel = await ApiService().profile(userId);
    // // debugPrint("${profileModel.status}");
    loading = false;
    notifyListeners();
  }

  getUpdateProfile({
    required String userId,
    required String fullname,
    required String email,
    required String contact,
    required String address,
    required String gender,
    required String age,
    File? image,
  }) async {
    loading = true;
    if (image != null) {
      successModel = await ApiService().updateProfile(
          email: email,
          userId: userId,
          image: image,
          address: address,
          contact: contact,
          age: age,
          // country: country,
          gender: gender,
          fullName: fullname);
      // // debugPrint("${profileModel.status}");
      loading = false;
      notifyListeners();
    } else {
      successModel = await ApiService().updateProfile(
          email: email,
          userId: userId,
          // image: image,
          address: address,
          contact: contact,
          age: age,
          // country: country,
          gender: gender,
          fullName: fullname);
      // // debugPrint("${profileModel.status}");
      loading = false;
      notifyListeners();
    }
  }

  getCoinsHistory(context, userId) async {
    loading = true;
    coinsHistoryModel = await ApiService().coinshistory(userId);
    // // debugPrint("${coinsHistoryModel.status}");
    loading = false;
    notifyListeners();
  }

  getRewardPoints(context, userId) async {
    loading = true;
    rewardModel = await ApiService().rewardpoints(userId);
    // // debugPrint("${referTranModel.status}");
    loading = false;
    notifyListeners();
  }

  getEarnPoints(context, userId) async {
    loading = true;
    earnModel = await ApiService().earnpoints(userId);
    // // debugPrint("${earnModel.status}");
    loading = false;
    notifyListeners();
  }

  getReferTransaction(context, userId) async {
    loading = true;
    referTranModel = await ApiService().referTran(userId);
    // // debugPrint("${referTranModel.status}");
    loading = false;
    notifyListeners();
  }

  getCategory(context) async {
    loading = true;
    categoryModel = await ApiService().category();
    // // debugPrint("${categoryModel.status}");
    loading = false;
    notifyListeners();
  }

  getCategoryByLevelMaster(context, masterId) async {
    loading = true;
    categoryMasterModel = await ApiService().categoryByLevelMaster(masterId);
    // // debugPrint("${categoryMasterModel.status}");
    loading = false;
    notifyListeners();
  }

  getLevel(context, catId, String userID) async {
    loading = true;
    levelModel = await ApiService().level(catId, userID);
    // // debugPrint("${levelModel.status}");
    loading = false;
    notifyListeners();
  }

  getQuestionByLevel(context, catId, String levelId) async {
    loading = true;
    questionModel = await ApiService().questionByLevel(catId, levelId);
    // // debugPrint("${questionModel.status}");
    loading = false;
    notifyListeners();
  }

  getUpContent(context, String listType, String userID) async {
    loading = true;
    upcontentModel = await ApiService().getContest(listType, userID);
    // // debugPrint("${upcontentModel.status}");
    loading = false;
    notifyListeners();
  }

  getLiveContent(context, String listType, String userID) async {
    loading = true;
    livecontentModel = await ApiService().getContest(listType, userID);
    // debugPrint("${livecontentModel.status}");
    loading = false;
    notifyListeners();
  }

  getEndContent(context, String listType, String userID) async {
    loading = true;
    endcontentModel = await ApiService().getContest(listType, userID);
    // debugPrint("${endcontentModel.status}");
    loading = false;
    notifyListeners();
  }

  getjoinContest(context, String contestId, String userID, String coin) async {
    loading = true;
    successModel = await ApiService().joinContest(contestId, userID, coin);
    // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getContestWinnerList(String contestId) async {
    loading = true;
    winnerModel = await ApiService().winnerbycontest(contestId);
    // debugPrint("${winnerModel.status}");
    loading = false;
    notifyListeners();
  }

  getContestLeaderBoard(userId, contestId) async {
    loading = true;
    contestLeaderModel =
        await ApiService().contestleaderBoard(userId, contestId);
    // debugPrint("====> ${contestLeaderModel.status}");
    loading = false;
    notifyListeners();
  }

  getQuestionByContest(context, catId) async {
    loading = true;
    contestQuestionModel = await ApiService().questionByContest(catId);
    // debugPrint("${contestQuestionModel.status}");
    loading = false;
    print('getQuestionByContest');
    notifyListeners();
  }

  changeQuestion(int id) {
    selectQuestion = id;
    notifyListeners();
  }

  getSaveQuestionReport(
      context,
      String levelId,
      String questionsAttended,
      String totalQuestion,
      String correctAnswers,
      String userId,
      String categoryId) async {
    loading = true;
    successModel = await ApiService().saveQuestionReport(levelId,
        questionsAttended, totalQuestion, correctAnswers, userId, categoryId);
    // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getSaveContestQuestionReport(
      context,
      String contestId,
      String questionsAttended,
      String totalQuestion,
      String correctAnswers,
      String userId,
      String questionJson) async {
    loading = true;
    successModel = await ApiService().saveContestQuestionReport(contestId,
        questionsAttended, totalQuestion, correctAnswers, userId, questionJson);
    // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getTodayLeaderBoard(context, userId, String levelId) async {
    loading = true;
    todayLeaderBoardModel =
        await ApiService().todayLeaderBoard(userId, levelId);
    // debugPrint("${todayLeaderBoardModel.status}");
    loading = false;
    notifyListeners();
  }

  getLeaderBoard(context, userId, String type) async {
    loading = true;
    leaderBoardModel = await ApiService().leaderBoard(userId, type);
    // debugPrint("${leaderBoardModel.status}");
    loading = false;
    notifyListeners();
  }

  getLevelMaster() async {
    loading = true;
    levelMasterModel = await ApiService().questionLevelMaster();
    // debugPrint("${levelMasterModel.status}");
    loading = false;
    notifyListeners();
  }

  getLevelPratice(context, catId, String userID) async {
    loading = true;
    levelPraticeModel =
        await ApiService().practiceLavelByCategoryId(catId, userID);
    // debugPrint("${levelPraticeModel.status}");
    loading = false;
    notifyListeners();
  }

  getQuestionByLevelPratice(
      context, catId, String levelId, String levelMasterId) async {
    loading = true;
    questionPraticeModel = await ApiService()
        .practiceQuestionByLavel(catId, levelId, levelMasterId);
    // debugPrint("${questionModel.status}");
    loading = false;
    notifyListeners();
  }

  getSavePraticeQuestionReport(
      context,
      String userId,
      String masterId,
      String categoryId,
      String levelId,
      String totalQuestion,
      String questionsAttended,
      String correctAnswers) async {
    loading = true;
    successModel = await ApiService().saveQuestionReport(levelId,
        questionsAttended, totalQuestion, correctAnswers, userId, categoryId);
    // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getPraticeLeaderBoard(userId) async {
    loading = true;
    praticeLeaderboardModel = await ApiService().practiseLeaderBoard(userId);
    // debugPrint("${praticeLeaderboardModel.status}");
    loading = false;
    notifyListeners();
  }

  getPackage(context, userId) async {
    loading = true;
    packagesModel = await ApiService().packages();
    // debugPrint("${profileModel.status}");
    loading = false;
    notifyListeners();
  }

  getaddTranscation(
      String userId, String planId, String amount, String coin) async {
    loading = true;
    successModel =
        await ApiService().addTransacation(userId, planId, amount, coin);
    // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getNotification(context, userId) async {
    loading = true;
    notificationModel = await ApiService().notification(userId);
    // debugPrint("${profileModel.status}");
    loading = false;
    notifyListeners();
  }

  getReadNotification(userId, id) async {
    loading = true;
    successModel = await ApiService().readNotification(userId, id);
    // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getEarnPointList() async {
    loading = true;
    earnPointsModel = await ApiService().earnPointslist();
    // debugPrint("${earnPointsModel.status}");
    loading = false;
    notifyListeners();
  }

  getaddRewardPoints(userId, id, type) async {
    loading = true;
    successModel = await ApiService().rewardPoints(userId, id, type);
    // debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }
}
