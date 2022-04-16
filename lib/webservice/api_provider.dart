import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quizapp/Model/GeneralSettingModel.dart';
import 'package:quizapp/webservice/apiservice.dart';

class ApiProvider with ChangeNotifier {
  GeneralSettingModel? _generalSettingModel;
  GeneralSettingModel? get generalSettingModel => _generalSettingModel;

  Future<void> fetchgeneralSettings(BuildContext context) async {
    final response = await ApiService().genaralSetting();
    if (response.statusCode == 200) {
      debugPrint('==>' + response.data);
      _generalSettingModel = GeneralSettingModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load album');
    }
    notifyListeners();
  }
}
