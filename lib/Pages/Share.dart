import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/widget/MyAppbar.dart';
import 'package:quizapp/widget/myText.dart';

bool topBar = false;

class Share extends StatefulWidget {
  const Share({Key? key}) : super(key: key);

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return buildViewPager();
  }

  buildViewPager() {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [
              Container(
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
          ),
          buildShareIcon()
        ],
      ),
    );
  }

  getAppbar() {
    return const MyAppbar(title: "Share App");
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 20),
        Image.asset('assets/images/ic_share.png', height: 100),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Text(
              "Share the love by inviting your friends and both of you will get points",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
        ),
        const SizedBox(height: 30),
        DottedBorder(
          dashPattern: const [4, 4],
          strokeWidth: 1,
          color: white,
          child: Container(
            height: 60,
            width: 280,
            color: tabbarunselect,
            child: Center(
              child: MyText(
                title: "VhoWIH",
                size: 24,
                fontWeight: FontWeight.w600,
                colors: white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Text("Copy your code",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.normal, color: white)),
        ),
      ]),
    );
  }

  buildShareIcon() {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
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
                    Image.asset(
                      "assets/images/ic_fb.png",
                      height: 60,
                    ),
                    const SizedBox(height: 5),
                    MyText(
                        title: "Facebook",
                        size: 16,
                        fontWeight: FontWeight.w500)
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/ic_tw.png",
                      height: 60,
                    ),
                    const SizedBox(height: 5),
                    MyText(
                        title: "Twitter", size: 16, fontWeight: FontWeight.w500)
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/ic_gp.png",
                      height: 60,
                    ),
                    const SizedBox(height: 5),
                    MyText(
                        title: "Google +",
                        size: 16,
                        fontWeight: FontWeight.w500)
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
                    Image.asset(
                      "assets/images/ic_line.png",
                      height: 60,
                    ),
                    const SizedBox(height: 5),
                    MyText(title: "Line", size: 16, fontWeight: FontWeight.w500)
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/ic_wp.png",
                      height: 60,
                    ),
                    const SizedBox(height: 5),
                    MyText(
                        title: "Whatsapp",
                        size: 16,
                        fontWeight: FontWeight.w500)
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/ic_sms.png",
                      height: 60,
                    ),
                    const SizedBox(height: 5),
                    MyText(title: "SMS", size: 16, fontWeight: FontWeight.w500)
                  ],
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
