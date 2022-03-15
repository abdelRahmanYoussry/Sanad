import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Model/CategoryModel.dart';
import 'package:quizapp/Model/GetLevel.dart';
import 'package:quizapp/Theme/theme_model.dart';

import '../Model/GeneralSettingModel.dart';
import '../webservice/apiservice.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz', style: TextStyle(color: Colors.white)).tr(),
        elevation: 0,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Test');
            },
          ),
        ],
      ),
      body: Container(margin: EdgeInsets.all(10), child: getBotton()),
    );
  }

  Widget getBotton() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            fetchgeneralSettings();
          },
          child: Text('General Setting'),
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.amber,
          ), // Background Color
        ),
        TextButton(
          onPressed: () {
            login("test@gmail.com", '12345', "3", "test123");
          },
          child: Text('Login'),
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.amber,
          ), // Background Color
        ),
        TextButton(
          onPressed: () {
            getCategory();
          },
          child: Text('Category'),
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.amber,
          ), // Background Color
        ),
        TextButton(
          onPressed: () {
            getLeval('2', '1');
          },
          child: Text('Get Level'),
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.amber,
          ), // Background Color
        ),
      ],
    );
  }

  Future<GeneralSettingModel> fetchgeneralSettings() async {
    final response = await ApiService().genaralSetting();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      return GeneralSettingModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<GeneralSettingModel> login(
      String email, String password, String type, String device_token) async {
    final response =
        await ApiService().login(email, password, type, device_token);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      return GeneralSettingModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<CategoryModel> getCategory() async {
    final response = await ApiService().categorylist();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Get Category==>" + response.data);
      return CategoryModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<GetLevel> getLeval(String categoryID, String userID) async {
    final response = await ApiService().getLeval(categoryID, userID);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      return GetLevel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
