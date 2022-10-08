import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/widget/myappbar.dart';
import 'package:quizapp/widget/myimage.dart';

import '../widget/mytext.dart';

bool topBar = false;

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  _ReferEarnState createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  SharePref sharePref = SharePref();
  String? reference;

  @override
  void initState() {
    getSharedPre();
    super.initState();
  }

  getSharedPre() async {
    reference = await sharePref.read('reference') ?? "";
    debugPrint('reference===>${reference.toString()}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return buildViewPager();
  }

  buildViewPager() {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 430,
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
                buildBody(),
              ],
            ),
          ]),
          buildShareIcon()
        ],
      ),
    );
  }

  getAppbar() {
    return const MyAppbar(title: "Share App");
  }

  buildBody() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: 20),
      Image.asset('assets/images/ic_share.png', height: 90),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Center(
          child: Text(
              "Share the love by inviting your friends and both of you will get points",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
        ),
      ),
      const SizedBox(height: 30),
      DottedBorder(
        dashPattern: const [4, 4],
        strokeWidth: 1,
        color: white,
        child: Container(
          height: 50,
          width: 250,
          color: tabbarunselect,
          child: Center(
            child: MyText(
              title: reference ?? "",
              size: 24,
              fontWeight: FontWeight.w600,
              colors: white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Text("Copy your code",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.normal, color: white)),
      ),
    ]);
  }

  buildShareIcon() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
              title: "Share to your friend by using these",
              size: 18,
              fontWeight: FontWeight.w500),
          const SizedBox(height: 20),
          Row(
            children: [
              const Spacer(),
              Column(
                children: [
                  MyImage(
                      width: 50,
                      height: 50,
                      imagePath: "assets/images/ic_fb.png"),
                  const SizedBox(height: 5),
                  MyText(
                      title: "Facebook", size: 14, fontWeight: FontWeight.w500)
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  MyImage(
                      width: 50,
                      height: 50,
                      imagePath: "assets/images/ic_tw.png"),
                  const SizedBox(height: 5),
                  MyText(
                      title: "Twitter", size: 14, fontWeight: FontWeight.w500)
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  MyImage(
                      width: 50,
                      height: 50,
                      imagePath: "assets/images/ic_gp.png"),
                  const SizedBox(height: 5),
                  MyText(
                      title: "Google +", size: 14, fontWeight: FontWeight.w500)
                ],
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Spacer(),
              Column(
                children: [
                  MyImage(
                      width: 50,
                      height: 50,
                      imagePath: "assets/images/ic_line.png"),
                  const SizedBox(height: 5),
                  MyText(title: "Line", size: 14, fontWeight: FontWeight.w500)
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  MyImage(
                      width: 50,
                      height: 50,
                      imagePath: "assets/images/ic_wp.png"),
                  const SizedBox(height: 5),
                  MyText(
                      title: "Whatsapp", size: 14, fontWeight: FontWeight.w500)
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  MyImage(
                      width: 50,
                      height: 50,
                      imagePath: "assets/images/ic_sms.png"),
                  const SizedBox(height: 5),
                  MyText(title: "SMS", size: 14, fontWeight: FontWeight.w500)
                ],
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
