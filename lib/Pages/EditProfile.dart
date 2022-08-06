import 'package:flutter/material.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/widget/myText.dart';
import 'package:quizapp/widget/myappbar.dart';

bool topBar = false;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return buildProfile();
  }

  buildProfile() {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dash_bg.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(50.0, 50.0)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getAppbar(),
                  buildHeader(),
                ],
              ),
            ]),
            buildData(),
          ],
        ),
      ),
    );
  }

  getAppbar() {
    return const MyAppbar(title: "Edit Profile");
  }

  buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 10),
            Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/ic_user_default.png',
                    height: 140)),
            const SizedBox(height: 10),
          ]),
          Positioned(
              child: Image.asset(
            'assets/images/ic_camera.png',
            height: 70,
          ))
        ],
      ),
    );
  }

  buildData() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            MyText(
                title: "  User Name",
                size: 16,
                fontWeight: FontWeight.w500,
                colors: black),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/ic_profile_user.png',
                      height: 10,
                      width: 10,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: "User Name",
                  fillColor: Colors.white70),
            ),
//  Email ID
            const SizedBox(height: 15),
            MyText(
                title: "  Email ID",
                size: 16,
                fontWeight: FontWeight.w500,
                colors: black),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/ic_profile_email.png',
                      height: 10,
                      width: 10,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: "Email ID",
                  fillColor: Colors.white70),
            ),

            // Contact No.

            const SizedBox(height: 15),
            MyText(
                title: "  Contact No.",
                size: 16,
                fontWeight: FontWeight.w500,
                colors: black),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/ic_profile_contact.png',
                      height: 10,
                      width: 10,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: "Contact No.",
                  fillColor: Colors.white70),
            ),

            // Address

            const SizedBox(height: 15),
            MyText(
                title: "  Address",
                size: 16,
                fontWeight: FontWeight.w500,
                colors: black),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/ic_profile_address.png',
                      height: 10,
                      width: 10,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: "Address",
                  fillColor: Colors.white70),
            ),

            const SizedBox(height: 40),
            Center(
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0))),
                      backgroundColor: MaterialStateProperty.all(appColor)),
                  child: MyText(
                    title: ' Save ',
                    size: 18,
                    fontWeight: FontWeight.w500,
                    colors: white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
