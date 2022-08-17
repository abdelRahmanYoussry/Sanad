import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quizapp/model/categorymastermodel.dart';
import 'package:quizapp/model/categorymodel.dart';
import 'package:quizapp/model/contentmodel.dart';
import 'package:quizapp/model/contestquestionmodel.dart';
import 'package:quizapp/model/generalsettingmodel.dart';
import 'package:quizapp/model/leaderboardmodel.dart';
import 'package:quizapp/model/levelmastermodel.dart';
import 'package:quizapp/model/levelmodel.dart';
import 'package:quizapp/model/levelpraticemodel.dart';
import 'package:quizapp/model/loginmodel.dart';
import 'package:quizapp/model/praticeleaderboardmodel.dart';
import 'package:quizapp/model/profilemodel.dart';
import 'package:quizapp/model/questionmodel.dart';
import 'package:quizapp/model/questionpraticemodel.dart';
import 'package:quizapp/model/refertranmodel.dart';
import 'package:quizapp/model/registrationmodel.dart';
import 'package:quizapp/model/successmodel.dart';
import 'package:quizapp/model/todayleaderboardmodel.dart';
import 'package:quizapp/pages/leaderboard.dart';
import 'package:quizapp/webservice/apiservice.dart';

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

  ProfileModel profileModel = ProfileModel();

  ReferTranModel referTranModel = ReferTranModel();
  SuccessModel successModel = SuccessModel();
  TodayLeaderBoardModel todayLeaderBoardModel = TodayLeaderBoardModel();
  LeaderBoardModel leaderBoardModel = LeaderBoardModel();

  LevelMasterModel levelMasterModel = LevelMasterModel();
  CategoryMasterModel categoryMasterModel = CategoryMasterModel();
  LevelPraticeModel levelPraticeModel = LevelPraticeModel();

  QuestionPraticeModel questionPraticeModel = QuestionPraticeModel();
  PraticeLeaderboardModel praticeLeaderboardModel = PraticeLeaderboardModel();

  bool loading = false;
  String? email, password, type, deviceToken;

  String? firstname, lastname, mobilenumber, fullname, username;

  String? catId;

  int? selectQuestion = 0;

  getGeneralsetting(context) async {
    loading = true;
    generalSettingModel = await ApiService().genaralSetting();
    debugPrint("${generalSettingModel.status}");
    loading = false;
    notifyListeners();
  }

  login(context, email, password, type, deviceToken) async {
    loading = true;
    loginModel = await ApiService().login(email, password, type, deviceToken);
    debugPrint("${loginModel.status}");
    loading = false;
    notifyListeners();
  }

  registration(context, email, password, firstname, lastname, mobilenumber,
      refercode, fullname, username) async {
    loading = true;
    debugPrint('====>$mobilenumber');
    registrationModel = await ApiService().registration(email, password,
        firstname, lastname, mobilenumber, refercode, fullname, username);
    debugPrint("${registrationModel.status}");
    loading = false;
    notifyListeners();
  }

  getProfile(context, userId) async {
    loading = true;
    profileModel = await ApiService().profile(userId);
    debugPrint("${profileModel.status}");
    loading = false;
    notifyListeners();
  }

  getUpdateProfile(
      userId, fullname, email, contact, address, File image) async {
    loading = true;
    successModel = await ApiService()
        .updateProfile(userId, fullname, email, contact, address, image);
    debugPrint("${profileModel.status}");
    loading = false;
    notifyListeners();
  }

  getReferTransaction(context, userId) async {
    loading = true;
    referTranModel = await ApiService().referTran(userId);
    debugPrint("${referTranModel.status}");
    loading = false;
    notifyListeners();
  }

  getCategory(context) async {
    loading = true;
    categoryModel = await ApiService().category();
    debugPrint("${categoryModel.status}");
    loading = false;
    notifyListeners();
  }

  getCategoryByLevelMaster(context, masterId) async {
    loading = true;
    categoryMasterModel = await ApiService().categoryByLevelMaster(masterId);
    debugPrint("${categoryMasterModel.status}");
    loading = false;
    notifyListeners();
  }

  getLevel(context, catId, String userID) async {
    loading = true;
    levelModel = await ApiService().level(catId, userID);
    debugPrint("${levelModel.status}");
    loading = false;
    notifyListeners();
  }

  getQuestionByLevel(context, catId, String levelId) async {
    loading = true;
    questionModel = await ApiService().questionByLevel(catId, levelId);
    debugPrint("${questionModel.status}");
    loading = false;
    notifyListeners();
  }

  getUpContent(context, String listType, String userID) async {
    loading = true;
    upcontentModel = await ApiService().getContest(listType, userID);
    debugPrint("${upcontentModel.status}");
    loading = false;
    notifyListeners();
  }

  getLiveContent(context, String listType, String userID) async {
    loading = true;
    livecontentModel = await ApiService().getContest(listType, userID);
    debugPrint("${livecontentModel.status}");
    loading = false;
    notifyListeners();
  }

  getEndContent(context, String listType, String userID) async {
    loading = true;
    endcontentModel = await ApiService().getContest(listType, userID);
    debugPrint("${endcontentModel.status}");
    loading = false;
    notifyListeners();
  }

  getjoinContest(context, String contestId, String userID, String coin) async {
    loading = true;
    successModel = await ApiService().joinContest(contestId, userID, coin);
    debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getContestWinnerList(String contestId) async {
    loading = true;
    successModel = await ApiService().winnerbycontest(contestId);
    debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getQuestionByContest(context, catId) async {
    loading = true;
    contestQuestionModel = await ApiService().questionByContest(catId);
    debugPrint("${contestQuestionModel.status}");
    loading = false;
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
    debugPrint("${successModel.status}");
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
    debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getTodayLeaderBoard(context, userId, String levelId) async {
    loading = true;
    todayLeaderBoardModel =
        await ApiService().todayLeaderBoard(userId, levelId);
    debugPrint("${todayLeaderBoardModel.status}");
    loading = false;
    notifyListeners();
  }

  getLeaderBoard(context, userId, String type) async {
    loading = true;
    leaderBoardModel = await ApiService().leaderBoard(userId, type);
    debugPrint("${leaderBoardModel.status}");
    loading = false;
    notifyListeners();
  }

  getLevelMaster() async {
    loading = true;
    levelMasterModel = await ApiService().questionLevelMaster();
    debugPrint("${levelMasterModel.status}");
    loading = false;
    notifyListeners();
  }

  getLevelPratice(context, catId, String userID) async {
    loading = true;
    levelPraticeModel =
        await ApiService().practiceLavelByCategoryId(catId, userID);
    debugPrint("${levelPraticeModel.status}");
    loading = false;
    notifyListeners();
  }

  getQuestionByLevelPratice(
      context, catId, String levelId, String levelMasterId) async {
    loading = true;
    questionPraticeModel = await ApiService()
        .practiceQuestionByLavel(catId, levelId, levelMasterId);
    debugPrint("${questionModel.status}");
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
    debugPrint("${successModel.status}");
    loading = false;
    notifyListeners();
  }

  getPraticeLeaderBoard(userId) async {
    loading = true;
    praticeLeaderboardModel = await ApiService().practiseLeaderBoard(userId);
    debugPrint("${praticeLeaderboardModel.status}");
    loading = false;
    notifyListeners();
  }
}
