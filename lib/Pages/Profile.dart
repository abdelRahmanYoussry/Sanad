import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Theme/color.dart';
import 'editprofile.dart';

bool topBar = false;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return buildProfile();
  }

  buildProfile() {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 400,
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
    );
  }

  getAppbar() {
    return AppBar(
      title: Text(
        "Profile",
        style: GoogleFonts.poppins(
            color: white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()));
              },
              child: Image.asset(
                "assets/images/ic_edit.png",
                width: 20,
              ),
            )),
      ],
    );
  }

  buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 10),
        Image.asset('assets/images/ic_user_default.png', height: 120),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Text("Arjun Patel",
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: CircleAvatar(
                  minRadius: 15,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/images/ic_icons.png")),
            ),
            const SizedBox(width: 5),
            Text("Gold",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ],
        ),
        const SizedBox(height: 20),
        IntrinsicHeight(
          child: Row(
            children: [
              const Spacer(),
              Column(
                children: [
                  Text("19",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  Text("Quizzes Played",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
              const Spacer(),
              const VerticalDivider(
                color: white,
                thickness: 0.5,
              ),
              const Spacer(),
              Column(
                children: [
                  Text("1600",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  Text("Points Earned",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
              const Spacer(),
            ],
          ),
        )
      ]),
    );
  }

  buildData() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 20),
            const CircleAvatar(
                minRadius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/ic_mail.png")),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textColorGrey)),
                Text("ckpate@divientechs.com",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: black)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 20),
            const CircleAvatar(
                minRadius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/ic_mobile.png")),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact No.",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textColorGrey)),
                Text("+91 7984859403",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: black)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 20),
            const CircleAvatar(
                minRadius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/ic_location.png")),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textColorGrey)),
                Text("501, PratikMall, Kudasan",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: black)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
