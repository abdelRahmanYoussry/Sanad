import 'package:flutter/material.dart';

import '../../theme/config.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({Key? key}) : super(key: key);

  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  TextEditingController CoinsController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController ageController = TextEditingController();
  // TextEditingController passController = TextEditingController();
  // TextEditingController confirmController = TextEditingController();
  // TextEditingController phonenumberController = TextEditingController();
  // TextEditingController referController = TextEditingController();
  // final SingleValueDropDownController genderController =
  //     SingleValueDropDownController();
  // final SingleValueDropDownController countryController =
  //     SingleValueDropDownController();
  // List<DropDownValueModel> genderTypeList = [
  //   const DropDownValueModel(name: 'Female', value: 0),
  //   const DropDownValueModel(name: 'Male', value: 1),
  // ];
  // List<DropDownValueModel> countryTypeList = [
  //   const DropDownValueModel(name: 'Egypt', value: 0),
  //   const DropDownValueModel(name: 'Malaysia', value: 1),
  // ];
  // List<SuccessModel>? loginList;
  //
  // final loginuser = GetStorage();
  //
  // SharePref sharePref = SharePref();
  //
  // bool _isObscure = true;
  // bool isloading = false;
  // bool isChecked = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    // passController.dispose();
    super.dispose();
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
                      "Withdraw",
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 2),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.2,
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
                          TextField(
                            controller: CoinsController,
                            decoration: const InputDecoration(
                                labelText: "Coins",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "Max 1000 Coin",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {},
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width / 1.4,
                            shape: const StadiumBorder(),
                            color: Config().appColor,
                            child: const Text(
                              "Withdraw",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
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
