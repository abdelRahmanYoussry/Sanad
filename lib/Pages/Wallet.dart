import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/widget/myText.dart';
import 'package:quizapp/widget/myappbar.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        Text("3265",
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
            children: <Widget>[
              rewardHistory(),
              rewardHistory(),
              rewardHistory()
            ],
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
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: 25,
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
                          backgroundImage:
                              AssetImage("assets/images/ic_reward_coins.png")),
                      Column(
                        children: [
                          Text(
                            "50",
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
                        children: const [
                          Text(
                            "Arjun Patel",
                            style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "22 July, 2021",
                            style:
                                TextStyle(color: textColorGrey, fontSize: 14),
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
          ),
        ),
      ]),
    );
  }
}
