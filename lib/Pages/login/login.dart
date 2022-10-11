import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/pages/home.dart';
import 'package:quizapp/pages/forgotpass.dart';
import 'package:quizapp/pages/login/otp.dart';
import 'package:quizapp/pages/login/signup.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/utils/adhelper.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/utils/utility.dart';
import '../../Model/SuccessModel.dart';
import '../../Theme/config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  List<SuccessModel>? loginList;

  SharePref sharePref = SharePref();

  final loginuser = GetStorage();

  bool _isObscure = true;
  bool isloading = false;
  bool isChecked = true;

  @override
  void initState() {
    AdHelper.getAds();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  _login(String email, String username, String profileImg, String password,
      String type) async {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    await provider.login(
        context, email, username, profileImg, password, type, "1");

    if (!provider.loading) {
      isloading = true;
      setState(() {});

      log("===>reference ${provider.loginModel.result?[0].referenceCode.toString()}");

      if (provider.loginModel.status == 200) {
        await sharePref.save('is_login', "1");
        await sharePref.save(
            'userId', provider.loginModel.result?[0].id.toString() ?? "");
        await sharePref.save('reference',
            provider.loginModel.result?[0].referenceCode.toString() ?? "");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        print(provider.loginModel.message);
        Utility.toastMessage("${provider.loginModel.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(top: 70),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/login_logo.png"),
                            fit: BoxFit.fitHeight)),
                  )),
              Expanded(
                flex: 7,
                child: ClipRRect(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/login_bg_white.png"),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    labelText: "Email Address",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                              Divider(
                                thickness: 0.5,
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              TextField(
                                obscureText: _isObscure,
                                controller: passController,
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey)),
                              ),
                              Divider(
                                thickness: 0.5,
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: (() {
                                    debugPrint('Test');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPass()));
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
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        // #signup_button
                        MaterialButton(
                          onPressed: () {
                            String email = emailController.text.trim();
                            String pass = passController.text.trim();
                            if (email.isEmpty) {
                              Utility.toastMessage(
                                  "Please enter email address");
                            } else if (pass.isEmpty) {
                              Utility.toastMessage("Please enter passoword");
                            } else {
                              isloading = true;
                              setState(() {});
                              _login(email, email, "", pass, "1");
                            }
                          },
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width / 1.4,
                          shape: const StadiumBorder(),
                          color: Config().appColor,
                          child: isloading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
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
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 70,
                                onPressed: () async {
                                  final googleUser =
                                      await GoogleSignIn().signIn();
                                  if (googleUser == null) return;

                                  GoogleSignInAccount _user = googleUser;

                                  log('===>email ${_user.email}');
                                  String email = _user.email;
                                  googleSignInUser(email);
                                },
                                icon: Image.asset("assets/images/icon_gm.png")),
                            IconButton(
                                iconSize: 70,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const OTP()));
                                },
                                icon: Image.asset(
                                    "assets/images/icon_mobile.png")),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 5),
                          child: GestureDetector(
                            onTap: (() {
                              debugPrint('Test');
                            }),
                            child: RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style:
                                      TextStyle(color: Config().appaccentColor),
                                ),
                                TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                        color: Config().appColor,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        debugPrint("Click");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUp()),
                                        );
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

  googleSignInUser(String mail) async {
    log(mail);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: '123456');
      log(userCredential.user!.uid);
      String firebasedid = userCredential.user!.uid;

      User? user = userCredential.user;
      log('===>mail $mail');
      log('===>display ${user?.displayName.toString()}');
      log('===>photoURL ${user?.photoURL.toString()}');

      _login(mail, user?.displayName.toString() ?? "",
          user?.photoURL.toString() ?? "", "123456", "2");
    } on FirebaseAuthException catch (e) {
      log('===>Exp${e.code.toString()}');
      log('===>Exp${e.message.toString()}');
      if (e.code.toString() == "user-not-found") {
        registerFirebaseUser(mail);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        Utility.toastMessage('Wrong password provided.');
      }
    }
  }

  registerFirebaseUser(String mail) async {
    log(mail);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: '123456')
          .whenComplete(() {});
      log('Register User : ${userCredential.user!.email.toString()}');
      log(userCredential.user!.uid);
      String firebasedid = userCredential.user!.uid;
      log("===> firebaseID $firebasedid");
      googleSignInUser(userCredential.user!.email.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        Utility.showAlertDialog(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      log(e.toString());
    }
  }
}
