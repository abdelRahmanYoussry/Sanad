import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Theme/config.dart';

class ApiService {
  String baseurl = Config().baseurl + "/api/";
  late Dio dio;

  ApiService() {
    dio = Dio();
  }

  Future<Response> genaralSetting() async {
    String generalsetting = "genaral_setting";
    Response response = await dio.get('$baseurl$generalsetting');
    debugPrint(response.data);
    return response;
  }

  Future<Response> login(
      final email, final password, final type, final devicetoken) async {
    String methodname = "login";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({
          "email": email,
          "password": password,
          "type": type,
          "device_token": devicetoken
        }));
    debugPrint(response.data);
    return response;
  }

  Future<Response> registration(
      final fullname, final email, final password, final phonenumber) async {
    String methodname = "registration";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({
          "fullname": fullname,
          "email": email,
          "password": password,
          "mobile": phonenumber,
        }));
    debugPrint(response.data);
    return response;
  }

  Future<Response> categorylist() async {
    String methodname = "get_category";
    debugPrint('$baseurl$methodname');
    Response response = await dio.get('$baseurl$methodname');
    debugPrint(response.data);
    return response;
  }

  Future<Response> getLeval(final categoryId, final userId) async {
    String methodname = "get_lavel";
    debugPrint('$baseurl$methodname');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"category_id": categoryId, "userId": userId}));
    debugPrint(response.data);
    return response;
  }
}
