import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:quizapp/Pages/AboutUs.dart';
import 'package:quizapp/Pages/Share.dart';
import 'package:quizapp/Pages/privacyPolicy.dart';
import 'package:quizapp/widget/CustomText.dart';

import '../Theme/color.dart';
import '../widget/CustomAppbar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [getAppbar(), const SizedBox(height: 30), buildBody()],
          ),
        ),
      ),
    );
  }

  getAppbar() {
    return const CustomAppbar(
      title: "Settings",
    );
  }

  buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          menuItem("About Us"),
          menuItem("Privacy Policy"),
          menuItem("Push Notification"),
          menuItem("App Language"),
          menuItem("Enable Sound"),
          menuItem("Enable Vibration"),
          menuItem("Share App"),
          menuItem("Rate App")
        ]),
      ),
    );
  }

  menuItem(String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'About Us') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutUs()));
        } else if (title == "Privacy Policy") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
        } else if (title == "Share App") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Share()));
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            children: [
              CustomText(title: title, size: 18, fontWeight: FontWeight.w600),
              const Spacer(),
              if (title == 'Push Notification' ||
                  title == 'Enable Sound' ||
                  title == 'Enable Vibration')
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                )
              else
                Image.asset("assets/images/ic_right_arrow.png", height: 15),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 0.5, color: textColorGrey),
        ],
      ),
    );
  }
}
