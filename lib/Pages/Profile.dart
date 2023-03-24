import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sanad/pages/login/login.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/theme/color.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/widget/mytext.dart';

import 'profileupdate.dart';

bool topBar = false;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userId;
  String? userGender;
  String? userAge;
  String? userCountry;
  int? totalCoins;
  int? totalPoints;
  SharePref sharePref = SharePref();

  @override
  initState() {
    getUserId();
    getUserAge();
    getUserCountry();
    getUserGender();
    getTotalCoins();
    getTotalPoints();
    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');

    if (userId != "" || userId != "0") {
      final profiledata = Provider.of<ApiProvider>(context, listen: false);
      profiledata.getProfile(context, userId);
      profiledata.getReferTransaction(context, userId);
    }
  }

  getUserGender() async {
    userGender = await sharePref.read('userGender') ?? "0";
    debugPrint('userGender===>${userGender.toString()}');
  }

  getUserAge() async {
    userAge = await sharePref.read('userAge') ?? "0";
    debugPrint('userAge===>${userAge.toString()}');
  }

  getUserCountry() async {
    userCountry = await sharePref.read('userCountry') ?? "0";
    debugPrint('userCountry===>${userCountry.toString()}');

    // if (userId != "" || userId != "0") {
    //   final profiledata = Provider.of<ApiProvider>(context, listen: false);
    //   profiledata.getProfile(context, userId);
    //   profiledata.getReferTransaction(context, userId);
    // }
  }

  getTotalCoins() async {
    totalCoins = await sharePref.read('totalCoins');
    debugPrint('totalCoins===>${totalCoins.toString()}');
  }

  getTotalPoints() async {
    totalPoints = await sharePref.read('totalPoints');
    debugPrint('totalPoints===>${totalPoints.toString()}');
  }

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }

  getAppbar() {
    return AppBar(
      title: Text(
        "Profile",
        style: GoogleFonts.poppins(
            color: black, fontSize: 20, fontWeight: FontWeight.w500),
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
                        builder: (context) => const ProfileUpdate()));
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
    return Consumer<ApiProvider>(
      builder: (context, profiledata, child) {
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 10),
          (profiledata.profileModel.result?[0].profileImg.toString() ?? "")
                  .isNotEmpty
              ? CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(profiledata
                          .profileModel.result?[0].profileImg
                          .toString() ??
                      ""))
              : Image.asset('assets/images/ic_user_default.png', height: 120),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: MyText(
                title:
                    (profiledata.profileModel.result?[0].fullname.toString() ??
                                "")
                            .isNotEmpty
                        ? (profiledata.profileModel.result?[0].fullname
                                .toString() ??
                            "")
                        : profiledata.profileModel.result?[0].email.toString(),
                size: 22,
                fontWeight: FontWeight.bold,
                colors: Colors.black,
              )),
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
                      color: Colors.black)),
            ],
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              children: [
                const Spacer(),
                //realCoins
                // Column(
                //   children: [
                //     Text(
                //         profiledata.profileModel.result?[0].totalScore
                //                 .toString() ??
                //             "",
                //         style: GoogleFonts.poppins(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w500,
                //             color: Colors.black)),
                //     Text("Coins",
                //         style: GoogleFonts.poppins(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w500,
                //             color: Colors.black)),
                //   ],
                // ),
                //fakeCoins
                Column(
                  children: [
                    Text(totalCoins.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    Text("Coins",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
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
                    //real points
                    // Text(
                    //     profiledata.profileModel.result?[0].totalPoints
                    //             .toString() ??
                    //         "",
                    //     style: GoogleFonts.poppins(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.black)),
                    //fake Points
                    Text(totalPoints.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    Text("Points",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ],
                ),
                const Spacer(),
              ],
            ),
          )
        ]);
      },
    );
  }

  buildData() {
    return Consumer<ApiProvider>(
      builder: (context, profiledata, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
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
                      MyText(
                        title: profiledata.profileModel.result?[0].email
                                .toString() ??
                            "",
                        size: 16,
                        fontWeight: FontWeight.w500,
                        colors: black,
                      )
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
                      backgroundImage:
                          AssetImage("assets/images/ic_mobile.png")),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact No.",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColorGrey)),
                      MyText(
                        title: profiledata.profileModel.result?[0].mobileNumber
                                .toString() ??
                            "",
                        size: 16,
                        fontWeight: FontWeight.w500,
                        colors: black,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CircleAvatar(
                    minRadius: 25,
                    backgroundColor: cyan.withOpacity(0.2),
                    child: Icon(Icons.flag, color: cyan),
                    // backgroundImage: AssetImage("assets/images/ic_location.png")
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Country",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColorGrey)),
                      MyText(
                        title:
                            profiledata.profileModel.result![0].address ?? "",
                        size: 16,
                        fontWeight: FontWeight.w500,
                        colors: black,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CircleAvatar(
                    minRadius: 25,
                    backgroundColor: cyan.withOpacity(0.2),
                    child: Icon(Icons.person, color: cyan),
                    // backgroundImage: AssetImage("assets/images/ic_location.png")
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Age",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColorGrey)),
                      MyText(
                        title: profiledata.profileModel.result![0].age ?? "",
                        size: 16,
                        fontWeight: FontWeight.w500,
                        colors: black,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CircleAvatar(
                    minRadius: 25,
                    backgroundColor: cyan.withOpacity(0.2),
                    child: userGender == 'Female'
                        ? Icon(Icons.female, color: cyan)
                        : Icon(Icons.male, color: cyan),
                    // backgroundImage: AssetImage("assets/images/ic_location.png")
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gender",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColorGrey)),
                      MyText(
                        title: profiledata.profileModel.result![0].gender ?? "",
                        size: 16,
                        fontWeight: FontWeight.w500,
                        colors: black,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CircleAvatar(
                    minRadius: 25,
                    backgroundColor: cyan.withOpacity(0.2),
                    child: IconButton(
                        onPressed: () {
                          sharePref.remove('is_login');
                          sharePref.remove('userId');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: cyan,
                        )),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Log Out",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColorGrey)),
                      // MyText(
                      //   title: (profiledata.profileModel.result?[0].biodata
                      //           .toString() ??
                      //       ""),
                      //   size: 16,
                      //   fontWeight: FontWeight.w500,
                      //   colors: black,
                      // )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
