import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/pages/profile.dart';
import 'package:quizapp/pages/settings.dart';
import 'package:quizapp/pages/wallet.dart';
import 'package:quizapp/pages/leaderboard.dart';
import 'package:quizapp/Theme/config.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/pages/instrucation.dart';
import 'package:quizapp/pages/login.dart';
import 'package:quizapp/pages/referearn.dart';
import 'package:quizapp/pages/spinwheel.dart';
import 'package:quizapp/utils/sharepref.dart';

import 'contest/contest.dart';
import 'pratise/praticestage.dart';
import 'quiz/category.dart';

bool topBar = false;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharePref sharePref = SharePref();

  @override
  initState() {
    getLogin();
    super.initState();
  }

  getLogin() async {
    String isLogin = await sharePref.read('is_login') ?? "0";
    debugPrint('===>$isLogin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: GestureDetector(
        onTap: (() => setState(() {
              topBar = false;
            })),
        child: Stack(
          children: [
            Container(
              height: 310,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [getAppbar(), buildBody()],
            ),
            topBar ? getTopBar() : Container(),
          ],
        ),
      ),
    );
  }

  getAppbar() {
    return AppBar(
      title: Text(
        Config().appName,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      leading: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: GestureDetector(
            child: Image.asset(
              'assets/images/ic_home.png',
              width: 50,
              height: 50,
            ),
            onTap: () {
              debugPrint("Home click");
              setState(() {
                topBar = true;
              });
            },
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: GestureDetector(
            child: Image.asset(
              'assets/images/ic_bell.png',
              width: 40,
            ),
            onTap: () {
              debugPrint("Bell Click");
            },
          ),
        ),
      ],
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
            child: Text("Welcome Back",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: Text(
              "DivineTechs Developer",
              style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          getDashboard(),
          const SizedBox(
            height: 10,
          ),
          getBottom(),
        ]),
      ),
    );
  }

  getDashboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Contest()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/red_bg.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Join in",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 18)),
                        Text("Contest",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Image.asset(
                            'assets/images/right_arrow.png',
                            height: 40.0,
                            width: 55.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PraticeStage()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/blue_bg.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Join in",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const Text(
                          "Practise",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Image.asset(
                            'assets/images/right_arrow.png',
                            height: 35.0,
                            width: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.22,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/green_bg.png"),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Join in",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 18)),
                      Text("Challenge",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Image.asset(
                          'assets/images/right_arrow.png',
                          height: 40.0,
                          width: 55.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Category()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/yellow_bg.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Join in",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const Text(
                          "Quiz",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Image.asset(
                            'assets/images/right_arrow.png',
                            height: 35.0,
                            width: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ],
    );
  }

  getBottom() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 40),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Other",
                style: GoogleFonts.poppins(
                    color: textColor,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey,
                  height: 1,
                  width: 70,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LeaderBoard()));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/level_lock.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Leaderboard',
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 0.3,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/level_lock.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Profile',
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              )),
              Container(
                color: Colors.grey,
                width: 0.3,
                height: 150,
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Instrucation()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/level_lock.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Instruction',
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 0.3,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settings()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/level_lock.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Setting',
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              )),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }

  getTopBar() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: textBoxColor,
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.elliptical(30.0, 30.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpinWheel()));
                  topBar = false;
                  setState(() {});
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/level_lock.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Spin & Win',
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.grey,
                height: 0.3,
                width: 100,
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Wallet()));
                  topBar = false;
                  setState(() {});
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/level_lock.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Wallet',
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          )),
          Container(
            color: Colors.grey,
            width: 0.3,
            height: 150,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReferEarn()));
                  topBar = false;
                  setState(() {});
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/level_lock.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Refer & Earn',
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.grey,
                height: 0.3,
                width: 100,
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  sharePref.remove('is_login');
                  sharePref.remove('userId');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Login()),
                      ModalRoute.withName('/'));
                  topBar = false;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/level_lock.png',
                      height: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Logout',
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          )),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
