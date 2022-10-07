import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/pages/subscription/subscription.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/utils/utility.dart';
import 'package:quizapp/widget/myappbar.dart';
import 'package:quizapp/widget/mytext.dart';

bool topBar = false;

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? userId,
      strEarnpoint,
      strEarnamount,
      strMinimumpoint,
      strCurrency,
      strWalletVisible;

  SharePref sharePref = SharePref();

  @override
  initState() {
    getUserId();

    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');
    strEarnpoint = await sharePref.read('earning_point') ?? "0";
    strEarnamount = await sharePref.read('earning_amount') ?? "0";
    strMinimumpoint = await sharePref.read('min_earning_point') ?? "0";
    strCurrency = await sharePref.read('currency') ?? "0";
    strWalletVisible =
        await sharePref.read('wallet_withdraw_visibility') ?? "0";
    debugPrint('strEarnpoint===>${strEarnpoint.toString()}');

    final profiledata = Provider.of<ApiProvider>(context, listen: false);
    profiledata.getProfile(context, userId);
    profiledata.getRewardPoints(context, userId);
    profiledata.getEarnPoints(context, userId);
    profiledata.getReferTransaction(context, userId);
  }

  @override
  Widget build(BuildContext context) {
    log("called");
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
              Row(
                children: [
                  Text(
                      profiledata.profileModel.result?[0].totalPoints
                              .toString() ??
                          "00",
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  const Spacer(),
                  strWalletVisible == "yes"
                      ? TextButton.icon(
                          icon: const Icon(Icons.currency_exchange),
                          onPressed: () {},
                          label: MyText(title: "Redeem"),
                          // child: MyText(title: "Add Coins"),
                          style: TextButton.styleFrom(
                              backgroundColor: white,
                              textStyle: const TextStyle(
                                  fontSize: 16, color: appColor)),
                        )
                      : Container(),
                  const SizedBox(width: 5),
                  TextButton.icon(
                    icon: const Icon(Icons.currency_exchange),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Subscription()));
                    },
                    label: MyText(title: "Add Coins"),
                    // child: MyText(title: "Add Coins"),
                    style: TextButton.styleFrom(
                        backgroundColor: white,
                        textStyle:
                            const TextStyle(fontSize: 16, color: appColor)),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              Row(
                children: [
                  MyText(
                    title: "Points",
                    size: 20,
                    fontWeight: FontWeight.w400,
                    colors: white,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "$strEarnpoint Points = $strEarnamount $strCurrency",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              MyText(
                title:
                    "*minimum $strMinimumpoint points required for withdrawal request.",
                size: 16,
                fontWeight: FontWeight.normal,
                colors: white,
              ),
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
                                MyText(
                                    title: rewardpoint.rewardModel
                                            .result?[index].rewardPoints ??
                                        "",
                                    size: 16,
                                    fontWeight: FontWeight.w500,
                                    colors: appColor),
                                MyText(
                                    title: "Points",
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                    colors: black),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                MyText(
                                    title: rewardpoint.rewardModel
                                            .result?[index].typename ??
                                        "",
                                    size: 18,
                                    fontWeight: FontWeight.w500,
                                    colors: black),
                                const SizedBox(height: 5),
                                MyText(
                                    title: Utility().dateConvert(
                                        rewardpoint.rewardModel.result?[index]
                                                .createdAt ??
                                            "",
                                        "MMM dd yyyy"),
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                    colors: textColorGrey),
                              ],
                            ),
                            const Spacer(),
                            MyText(
                                title: "Success",
                                size: 18,
                                fontWeight: FontWeight.w500,
                                colors: appgreen),
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
                                  earnpoint.earnModel.result?[index]
                                          .contestName ??
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
