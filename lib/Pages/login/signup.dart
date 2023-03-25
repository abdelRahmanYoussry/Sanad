import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sanad/pages/home.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/utils/utility.dart';
import 'package:sanad/widget/CustomDropDown.dart';

import '../../model/successmodel.dart';
import '../../theme/config.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController referController = TextEditingController();
  final SingleValueDropDownController genderController =
      SingleValueDropDownController();
  final SingleValueDropDownController countryController =
      SingleValueDropDownController();
  List<DropDownValueModel> genderTypeList = [
    const DropDownValueModel(name: 'Female', value: 0),
    const DropDownValueModel(name: 'Male', value: 1),
  ];
  List<DropDownValueModel> countryTypeList = [
    const DropDownValueModel(name: 'Egypt', value: 0),
    const DropDownValueModel(name: 'Malaysia', value: 1),
  ];
  List<SuccessModel>? loginList;

  final loginuser = GetStorage();

  SharePref sharePref = SharePref();

  bool _isObscure = true;
  bool isloading = false;
  bool isChecked = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _registration() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String pass = passController.text.trim();
    String phone = phonenumberController.text.trim();
    String refer = referController.text.trim();
    String gender = genderController.dropDownValue!.name;
    String age = ageController.text.trim();
    String country = countryController.dropDownValue!.name;

    if (username.isEmpty) {
      Utility.toastMessage("Please enter username");
    } else if (email.isEmpty) {
      Utility.toastMessage("Please enter email");
    } else {
      var provider = Provider.of<ApiProvider>(context, listen: false);
      await provider.registration(
        age: age, fullname: username, gender: gender,
        email: email, username: username, mobilenumber: phone,
        lastname: username, firstname: username,
        context: context, password: pass, refercode: refer,
        country: country,
        // context, email, pass, username, username,
        // phone, refer, username, username, age, gender
      );

      if (!provider.loading) {
        isloading = false;
        setState(() {});
        print("==>${provider.registrationModel.status}");
        if (provider.registrationModel.status == 200) {
          sharePref.save('is_login', "1");
          sharePref.save('userId',
              provider.registrationModel.result?[0].id.toString() ?? "");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
        } else {
          print(provider.registrationModel.message);
          Utility.toastMessage('${provider.registrationModel.message}');
        }
      }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 2),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login_bg_white.png"),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                                labelText: "User Name",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "User Name",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          // SizedBox(
                          //   height: size.height * 0.02,
                          // ),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                labelText: "Email Address",
                                labelStyle: TextStyle(color: Colors.black),
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
                          TextField(
                            controller: ageController,
                            onChanged: (value) {
                              sharePref.save('userAge', value);
                            },
                            decoration: const InputDecoration(
                                labelText: "ِAge",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "Age",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          // Divider(
                          //   thickness: 0.5,
                          //   height: size.height * 0.01,
                          // ),
                          MyCustomDropDown(
                              dropDownValueList: genderTypeList,
                              onChanged: (value) async {
                                sharePref.save('userGender', value.name);
                              },
                              borderSide: BorderSide.none,
                              onTap: () {},
                              isAutoValid: AutovalidateMode.disabled,
                              enableSearch: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Gender cant be empty';
                                } else {
                                  return null;
                                }
                              },
                              enableDropDown: true,
                              controller: genderController,
                              label: const Text('Select Your Gender')),
                          // SizedBox(
                          //   height: size.height * 0.01,
                          // ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          MyCustomDropDown(
                              dropDownValueList: countryTypeList,
                              onChanged: (value) async {
                                String country = value.name;
                                await sharePref.save('userCountry', country);
                              },
                              borderSide: BorderSide.none,
                              onTap: () {},
                              isAutoValid: AutovalidateMode.disabled,
                              enableSearch: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'County cant be empty';
                                } else {
                                  return null;
                                }
                              },
                              enableDropDown: true,
                              controller: countryController,
                              label: const Text('Select Your Country')),
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
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.grey)),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          TextField(
                            obscureText: _isObscure,
                            controller: confirmController,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
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
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(color: Colors.grey)),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: phonenumberController,
                            decoration: const InputDecoration(
                                labelText: "Phone Number",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "Phone Number",
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
                            controller: referController,
                            decoration: const InputDecoration(
                                labelText: "Referral Code",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "Referral Code",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          // #signup_button
                          MaterialButton(
                            onPressed: () {
                              String pass = passController.text.trim();
                              String confirm = confirmController.text.trim();
                              if (pass == confirm) {
                                isloading = true;
                                setState(() {});
                                _registration();
                              } else {
                                Utility.toastMessage(
                                    "Please check confirm password");
                              }
                            },
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width / 1.4,
                            shape: const StadiumBorder(),
                            color: Config().appColor,
                            child: isloading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
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
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                        color: Config().appaccentColor),
                                  ),
                                  TextSpan(
                                      text: "Sign In",
                                      style: TextStyle(
                                          color: Config().appColor,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pop();
                                        })
                                ],
                              )),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
