import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sanad/Cubit/app_cubit.dart';
import 'package:sanad/Theme/color.dart';
import 'package:sanad/Theme/config.dart';
import 'package:sanad/pages/StatisticsPage/StatisticsScreen.dart';
import 'package:sanad/pages/instrucation.dart';
import 'package:sanad/pages/leaderboard.dart';
import 'package:sanad/pages/login/login.dart';
import 'package:sanad/pages/notification.dart';
import 'package:sanad/pages/profile.dart';
import 'package:sanad/pages/referearn.dart';
import 'package:sanad/pages/settings.dart';
import 'package:sanad/pages/spinwheel.dart';
import 'package:sanad/pages/wallet.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/utils/adhelper.dart';
import 'package:sanad/utils/sharepref.dart';

import 'contest/contest.dart';

bool topBar = false;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharePref sharePref = SharePref();
  String? userId;
  int selectedIndex = 0;
  var androidBannerAdsId = "";
  var iosBannerAdsId = "";
  var bannerad = "";
  var banneradIos = "";
  double? totalCoins;
  @override
  initState() {
    getLogin();
    getId();
    // getTotalCoins();

    super.initState();
  }

  // getTotalCoins() async {
  //   totalCoins = await sharePref.read('totalCoins');
  //   debugPrint('totalCoins===>${totalCoins.toString()}');
  // }

  getId() async {
    androidBannerAdsId = await sharePref.read("banner_adid") ?? "";
    iosBannerAdsId = await sharePref.read("ios_banner_adid") ?? "";
    bannerad = await sharePref.read("banner_ad") ?? "";
    banneradIos = await sharePref.read("ios_banner_ad") ?? "";

    debugPrint("Android id:====$bannerad");
    debugPrint("ios id:====$banneradIos");
    final profiledata = Provider.of<ApiProvider>(context, listen: false);
    profiledata.getProfile(context, userId);
    totalCoins = double.parse(profiledata.profileModel.result![0].totalCoins!);
  }

  getLogin() async {
    userId = await sharePref.read('userId') ?? "";
    debugPrint('userID===>${userId.toString()}');
    String isLogin = await sharePref.read('is_login') ?? "0";
    debugPrint('===>$isLogin');

    if (userId != null || userId != "" || userId != "0") {
      final profiledata = Provider.of<ApiProvider>(context, listen: false);
      profiledata.getProfile(context, userId);
    }

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {});
    _googleSignIn.signInSilently();

    // await Constant.totalCoins(
    //     coins: int.parse(profiledata.profileModel.result![0].totalCoins!));
    // await Constant.totalPoints(
    //     points: profiledata.profileModel.result![0].totalScore!);
    AdHelper.createInterstitialAd();
    AdHelper.createRewardedAd();
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStateCubit>(
      listener: (context, state) {},
      builder: (context, state) {
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [getAppbar(), buildBody()],
                  ),
                ),
                topBar ? getTopBar() : Container(),
              ],
            ),
          ),
        );
      },
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
              AdHelper.showInterstitialAd();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Notifications()));
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
                    color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: Consumer<ApiProvider>(
              builder: (context, profiledata, child) {
                String? email =
                    profiledata.profileModel.result?[0].email.toString() ?? "";
                String? mobile = profiledata
                        .profileModel.result?[0].mobileNumber
                        .toString() ??
                    "";

                return Text(
                  email != "" ? email : mobile,
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                );
              },
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

  getTopBar() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
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
                  sharePref.clear();
                  _handleSignOut();
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

  getDashboard() {
    return BlocConsumer<AppCubit, AppStateCubit>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                      AdHelper.showInterstitialAd();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Contest()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/green2_bg.png"),
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
                            Text("Challenges",
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
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      AdHelper.showRewardedAd();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const Category()));
                      AppCubit.get(context).getStatistics(userId: userId!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StatisticsScreen()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/red2_bg.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Join in",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const Text(
                              "History",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                'assets/images/right_arrow.png',
                                height: 40.0,
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
                  width: 5,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  getBottom() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: AdWidget(
                ad: AdHelper.createBannerAd()..load(), key: UniqueKey()),
          ),
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
                      if (userId!.isNotEmpty || userId != "" || userId != "0") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }
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
          ),
        ],
      ),
    );
  }
}
