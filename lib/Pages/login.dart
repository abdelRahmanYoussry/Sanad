import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/LoginModel.dart';
import '../Model/SuccessModel.dart';
import '../Theme/config.dart';
import '../Utils/Utility.dart';
import '../webservice/apiservice.dart';
import '../widget/TextFields.dart';
import '../widget/TextView.dart';
import 'mainactivity.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  List<SuccessModel>? loginList;
  bool _isHidden = true;

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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/login_logo.png"),
                            fit: BoxFit.fitHeight)),
                  )),
              Expanded(
                flex: 6,
                child: ClipRRect(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/login_bg_white.png"),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 50),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const TextField(
                                decoration: InputDecoration(
                                    labelText: "Email Address",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                              const Divider(
                                thickness: 0.5,
                                height: 10,
                              ),
                              TextField(
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      onPressed: () => {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        }),
                                      },
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: (() {
                                    print('Test');
                                  }),
                                  child: const Text(
                                    "Forgot your password ?",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // #signup_button
                        MaterialButton(
                          onPressed: () {},
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width / 1.4,
                          shape: const StadiumBorder(),
                          color: Config().appColor,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Colors.grey,
                              height: 1,
                              width: 70,
                            ),
                            const Text(
                              "  Login with  ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            Container(
                              color: Colors.grey,
                              height: 1,
                              width: 70,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 70,
                                onPressed: () {},
                                icon: Image.asset("assets/images/icon_fb.png")),
                            IconButton(
                                iconSize: 70,
                                onPressed: () {},
                                icon: Image.asset("assets/images/icon_gm.png")),
                            IconButton(
                                iconSize: 70,
                                onPressed: () {},
                                icon: Image.asset(
                                    "assets/images/icon_mobile.png")),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: (() {
                              print('Test');
                            }),
                            child: RichText(
                                text: TextSpan(
                              children: [
                                new TextSpan(
                                  text: "Don't have an account? ",
                                  style: new TextStyle(
                                      color: Config().appaccentColor),
                                ),
                                new TextSpan(
                                    text: "Sign Up",
                                    style: new TextStyle(
                                        color: Config().appColor,
                                        fontStyle: Fon),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Click");
                                      })
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
