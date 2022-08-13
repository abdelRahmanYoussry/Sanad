import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/model/categorymodel.dart';
import 'package:quizapp/model/contentmodel.dart';
import 'package:quizapp/model/generalsettingmodel.dart';
import 'package:quizapp/model/levelmodel.dart';
import 'package:quizapp/model/loginmodel.dart';
import 'package:quizapp/model/profilemodel.dart';
import 'package:quizapp/model/questionmodel.dart';
import 'package:quizapp/model/refertranmodel.dart';
import 'package:quizapp/model/registrationmodel.dart';
import 'package:quizapp/utils/constant.dart';

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

  Future<LoginModel> login(
      String email, String pass, String type, String devicetoken) async {
    LoginModel loginmodel;
    String login = "login";
    Response response = await dio.post('$baseurl$login',
        data: ({
          'email': email,
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
}
