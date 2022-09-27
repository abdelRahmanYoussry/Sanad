import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/utils/utility.dart';
import 'package:quizapp/widget/myText.dart';
import 'package:quizapp/widget/myappbar.dart';

bool topBar = false;

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
    profiledata.getRewardPoints(context, userId);
    profiledata.getEarnPoints(context, userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    height: 260,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getAppbar(),
                      buildBody(),
                    ],
                  ),
                ]),
              ],
            ),
            DefaultTabController(length: 3, child: buildPager())
          ],
        ),
      ),
    );
  }

  getAppbar() {
    return const MyAppbar(title: "Wallet");
  }

  buildBody() {
    return Consumer<ApiProvider>(
      builder: (context, profiledata, child) {
        if (profiledata.loading) {
          return const CircularProgressIndicator();
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 10),
              Text(
                  profiledata.profileModel.result?[0].totalPoints.toString() ??
                      "00",
                  style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              Row(
                children: [
                  Text(
                    "Points",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "1500 Points = 10 USD",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text("*minimum 100 points required for withdrawal request.",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ]),
          );
        }
      },
    );
  }

  buildPager() {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: TabBar(
            indicatorColor: appColor,
            labelColor: appColor,
            unselectedLabelColor: appaccentColor,
            tabs: [
              MyText(title: 'Reward', size: 16, fontWeight: FontWeight.w500),
              MyText(title: 'Earn', size: 16, fontWeight: FontWeight.w500),
              MyText(title: 'Refer', size: 16, fontWeight: FontWeight.w500)
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          child: TabBarView(
            children: <Widget>[rewardHistory(), earnpoint(), referHistory()],
          ),
        )
      ],
    );
  }

  rewardHistory() {
    return Positioned.fill(
      top: 350,
      bottom: 80,
      left: 0,
      right: 0,
      child: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<ApiProvider>(
            builder: (context, rewardpoint, child) {
              if (rewardpoint.loading) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: rewardpoint.rewardModel.result?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(
                          left: 15, top: 5, right: 15, bottom: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const CircleAvatar(
                                minRadius: 30,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                    "assets/images/ic_reward_coins.png")),
                            Column(
                              children: [
                                Text(
                                  rewardpoint.rewardModel.result?[index]
                                          .rewardPoints ??
                                      "",
                                  style: GoogleFonts.poppins(
                                      color: appColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Points",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  rewardpoint.rewardModel.result?[index]
                                          .rewardPoints ??
                                      "",
                                  style: const TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Utility().dateConvert(
                                      rewardpoint.rewardModel.result?[index]
                                              .createdAt ??
                                          "",
                                      "MMM dd yyyy"),
                                  style: const TextStyle(
                                      color: textColorGrey, fontSize: 14),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              "Success",
                              style: TextStyle(
                                  color: appgreen,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ]),
    );
  }

  earnpoint() {
    return Positioned.fill(
      top: 350,
      bottom: 80,
      left: 0,
      right: 0,
      child: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<ApiProvider>(
            builder: (context, earnpoint, child) {
              if (earnpoint.loading) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: earnpoint.earnModel.result?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(
                          left: 15, top: 5, right: 15, bottom: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const CircleAvatar(
                                minRadius: 30,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                    "assets/images/ic_reward_coins.png")),
                            Column(
                              children: [
                                Text(
                                  earnpoint.earnModel.result?[index].point ??
                                      "",
                                  style: GoogleFonts.poppins(
                                      color: appColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Points",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  earnpoint.earnModel.result?[index].point ??
                                      "",
                                  style: const TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Utility().dateConvert(
                                      earnpoint.earnModel.result?[index]
                                              .createdAt ??
                                          "",
                                      "MMM dd yyyy"),
                                  style: const TextStyle(
                                      color: textColorGrey, fontSize: 14),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              "Success",
                              style: TextStyle(
                                  color: appgreen,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ]),
    );
  }

  referHistory() {
    return Positioned.fill(
      top: 350,
      bottom: 80,
      left: 0,
      right: 0,
      child: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<ApiProvider>(
            builder: (context, referdata, child) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: referdata.referTranModel.result?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.only(
                        left: 15, top: 5, right: 15, bottom: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const CircleAvatar(
                              minRadius: 30,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                  "assets/images/ic_reward_coins.png")),
                          Column(
                            children: [
                              Text(
                                referdata.referTranModel.result?[index]
                                        .referedPoint
                                        .toString() ??
                                    "",
                                style: GoogleFonts.poppins(
                                    color: appColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Points",
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text(
                                referdata.referTranModel.result?[index].userName
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                referdata.referTranModel.result?[index]
                                        .referedDate
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                    color: textColorGrey, fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Text(
                            "Success",
                            style: TextStyle(
                                color: appgreen,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
