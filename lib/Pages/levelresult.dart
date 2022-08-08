import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/pages/level.dart';
import 'package:quizapp/theme/color.dart';

import '../widget/mytext.dart';

class LevelResult extends StatefulWidget {
  const LevelResult({Key? key}) : super(key: key);

  @override
  State<LevelResult> createState() => _LevelResultState();
}

class _LevelResultState extends State<LevelResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/appbg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: getAppbar(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Expanded(
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                title:
                                    "Congratulations!\nYou have completed level.",
                                size: 18,
                                fontWeight: FontWeight.w500,
                                colors: white,
                                textalign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/images/ic_user_dummy.png",
                                width: 90,
                              ),
                              Center(
                                child: MyText(
                                  title: "Arjun Patel",
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  colors: white,
                                  textalign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                              MyText(
                                title: "125+ Points Earned.",
                                fontWeight: FontWeight.w500,
                                colors: white,
                                size: 18,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const Level()));
                                          },
                                          child: MyText(
                                            title: "Play Next Level",
                                            colors: white,
                                            fontWeight: FontWeight.w500,
                                            size: 16,
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      primary),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      side: const BorderSide(
                                                          color: white))))),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: MyText(
                                            title: "Share Result",
                                            colors: primary,
                                            fontWeight: FontWeight.w500,
                                            size: 16,
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      white),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      side: const BorderSide(
                                                          color: white))))),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildBody(),
              // getBottom()
            ],
          ),
        ),
      ),
    );
  }

  getAppbar() {
    return AppBar(
      title: const Text(
        "Level Result",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  buildBody() {
    return Positioned.fill(
      top: 280,
      bottom: 80,
      left: 0,
      right: 0,
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: 25,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Text("1",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 16)),
                    const SizedBox(width: 15),
                    const CircleAvatar(
                        minRadius: 25,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage("assets/images/ic_user_dummy.png")),
                    const SizedBox(width: 10),
                    const Text(
                      "Arjun Patel",
                      style: TextStyle(color: black),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Image.asset("assets/images/ic_icons.png"),
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      "18,400",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(height: 1, thickness: 1),
              );
            },
          ),
        ),
      ]),
    );
  }
}
