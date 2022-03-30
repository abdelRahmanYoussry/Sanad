import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Theme/color.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/dash_bg.png"),
                      fit: BoxFit.cover,
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 15),
                        Expanded(
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 80),
                                Text(
                                  "#2",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Image.asset(
                                  "assets/images/ic_user_dummy.png",
                                  width: 70,
                                ),
                                Center(
                                  child: Text(
                                    "Laila Rama",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                          "assets/images/ic_icons.png"),
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      "18,400",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Image.asset(
                                  "assets/images/ic_user_top.png",
                                  width: 60,
                                ),
                                Image.asset(
                                  "assets/images/ic_user_dummy.png",
                                  width: 100,
                                ),
                                Center(
                                  child: Text(
                                    "Sahil Patelasdasdssdsd",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                          "assets/images/ic_icons.png"),
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      "18,400",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 80),
                                Text(
                                  "#3",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Image.asset(
                                  "assets/images/ic_user_dummy.png",
                                  width: 70,
                                ),
                                Center(
                                  child: Text(
                                    "Arjun Sharma",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                          "assets/images/ic_icons.png"),
                                      height: 30,
                                      width: 30,
                                    ),
                                    Text(
                                      "18,400",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            getAppbar(),
            buildBody(),
            getBottom()
          ],
        ),
      ),
    );
  }

  getAppbar() {
    return AppBar(
      title: const Text(
        "Leaderboard",
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
      top: 350,
      bottom: 80,
      left: 0,
      right: 0,
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))),
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

  getBottom() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: leaderSelect,
              border: Border.all(color: appColor),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          height: 60,
          child: Row(
            children: [
              const SizedBox(width: 15),
              Text("1",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 16)),
              const SizedBox(width: 15),
              const CircleAvatar(
                  minRadius: 25,
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      AssetImage("assets/images/ic_user_dummy.png")),
              const SizedBox(width: 10),
              const Text("Arjun Patel"),
              const Spacer(),
              SizedBox(
                child: Image.asset("assets/images/ic_icons.png"),
                height: 30,
                width: 30,
              ),
              Text(
                "18,400",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}
