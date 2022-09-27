import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/pages/home.dart';
import 'package:quizapp/pages/forgotpass.dart';
import 'package:quizapp/pages/signup.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/utils/sharepref.dart';
import '../Model/SuccessModel.dart';
import '../Theme/config.dart';

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

  bool isChecked = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String email = emailController.text.trim();
    String pass = passController.text.trim();

    var provider = Provider.of<ApiProvider>(context, listen: false);
    await provider.login(context, email, pass, "1", "1");
    if (provider.loading) {
      const CircularProgressIndicator();
    } else {
      print("==>${provider.loginModel.status}");
      if (provider.loginModel.status == 200) {
        await sharePref.save('is_login', "1");
        await sharePref.save(
            'userId', provider.loginModel.result?[0].id.toString() ?? "");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        print(provider.loginModel.message);
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
                            _login();
                          },
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
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                },
                                icon: Image.asset("assets/images/icon_fb.png")),
                            IconButton(
                                iconSize: 70,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                },
                                icon: Image.asset("assets/images/icon_gm.png")),
                            IconButton(
                                iconSize: 70,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
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
}
