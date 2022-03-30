import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/widget/CustomAppbar.dart';

import '../widget/CustomText.dart';

bool topBar = false;

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return buildViewPager();
  }

  buildViewPager() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                Stack(children: [
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
                    children: [
                      getAppbar(),
                      const SizedBox(height: 10),
                      buildBody(),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAppbar() {
    return const CustomAppbar(title: "Wallet");
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
            child: Text("Welcome Back",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
            child: Text(
              "DivineTechs Developer",
              style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

  buildPager() {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: tabbarunselect, borderRadius: BorderRadius.circular(25.0)),
          child: TabBar(
            indicator: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(25.0)),
            labelColor: appColor,
            unselectedLabelColor: white,
            tabs: [
              CustomText(
                  title: 'Upcoming', size: 16, fontWeight: FontWeight.w500),
              CustomText(title: 'Live', size: 16, fontWeight: FontWeight.w500),
              CustomText(title: 'Ended', size: 16, fontWeight: FontWeight.w500)
            ],
          ),
        ),
        Expanded(
            child: TabBarView(
          children: [rewardHistory(), rewardHistory(), rewardHistory()],
        ))
      ],
    );
  }

  rewardHistory() {
    return CustomText(title: "title", size: 16, fontWeight: FontWeight.w600);
  }
}
