import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/widget/mytext.dart';
import 'profileupdate.dart';

bool topBar = false;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userId;
  SharePref sharePref = SharePref();

  @override
  initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');

    final profiledata = Provider.of<ApiProvider>(context, listen: false);
    profiledata.getProfile(context, userId);
    profiledata.getReferTransaction(context, userId);
  }

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
                    profiledata.profileModel.result?[0].fullname.toString() ??
                        "",
                size: 22,
                fontWeight: FontWeight.w500,
                colors: Colors.white,
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
                    Text(
                        profiledata.profileModel.result?[0].totalScore
                                .toString() ??
                            "",
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
                    Text(
                        profiledata.profileModel.result?[0].totalPoints
                                .toString() ??
                            "",
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
        ]);
      },
    );
  }

  buildData() {
    return Consumer<ApiProvider>(
      builder: (context, profiledata, child) {
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
                const CircleAvatar(
                    minRadius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage("assets/images/ic_location.png")),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textColorGrey)),
                    MyText(
                      title: profiledata.profileModel.result?[0].biodata
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
          ],
        );
      },
    );
  }
}
