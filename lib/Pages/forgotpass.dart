import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/LoginModel.dart';
import '../Model/SuccessModel.dart';
import '../Theme/config.dart';

import '../webservice/apiservice.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  List<SuccessModel>? loginList;

  final loginuser = GetStorage();

  bool _isObscure = true;

  bool isChecked = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<LoginModel> signIn() async {
    String strEmail = emailController.text;
    String strPass = passController.text;
    final response =
        await ApiService().login(strEmail, strPass, "1", "345354354");
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        height: 2,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Enter your Email address to reset your password to join the application",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Container(
                  color: Colors.white,
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/images/login_bg_white.png"),
                  //         fit: BoxFit.cover)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: "Email Address",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: InputBorder.none,
                              hintText: "Email ID",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                        Divider(
                          thickness: 0.5,
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width / 1.4,
                          shape: const StadiumBorder(),
                          color: Config().appColor,
                          child: const Text(
                            "Send",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
