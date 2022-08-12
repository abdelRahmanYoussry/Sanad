import 'package:flutter/material.dart';
import 'package:quizapp/model/generalsettingmodel.dart';
import 'package:quizapp/model/loginmodel.dart';
import 'package:quizapp/model/registrationmodel.dart';
import 'package:quizapp/webservice/apiservice.dart';

class ApiProvider extends ChangeNotifier {
  GeneralSettingModel generalSettingModel = GeneralSettingModel();

  LoginModel loginModel = LoginModel();

  RegistrationModel registrationModel = RegistrationModel();

  bool loading = false;
  String? email, password, type, deviceToken;

  String? firstname, lastname, mobilenumber, fullname, username;

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
}
