import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/widget/mytext.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  String? userId;
  String? type = "all";
  SharePref sharePref = SharePref();

  @override
  initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');

    final leaderboarddata = Provider.of<ApiProvider>(context, listen: false);
    leaderboarddata.getLeaderBoard(context, userId.toString(), type.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Consumer<ApiProvider>(
                builder: (context, leaderdata, child) {
                  return Column(
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
                            (leaderdata.leaderBoardModel.result?.length ?? 0) >
                                    0
                                ? Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 80),
                                          Text(
                                            "#2",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: primary,
                                            backgroundImage: NetworkImage(
                                                leaderdata
                                                        .leaderBoardModel
                                                        .result?[1]
                                                        .profileImg ??
                                                    ""),
                                          ),
                                          Center(
                                            child: Text(
                                              leaderdata.leaderBoardModel
                                                      .result?[1].fullname ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Image.asset(
                                                    "assets/images/ic_icons.png"),
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                leaderdata.leaderBoardModel
                                                        .result?[1].totalScore
                                                        .toString() ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 80),
                                          Text(
                                            "#2",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          const CircleAvatar(
                                            radius: 40,
                                            backgroundColor: primary,
                                            backgroundImage: NetworkImage(""),
                                          ),
                                          Center(
                                            child: Text(
                                              "",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Image.asset(
                                                    "assets/images/ic_icons.png"),
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                "",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            (leaderdata.leaderBoardModel.result?.length ?? 0) >
                                    1
                                ? Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          Image.asset(
                                            "assets/images/ic_user_top.png",
                                            width: 60,
                                          ),
                                          CircleAvatar(
                                            radius: 55,
                                            backgroundColor: primary,
                                            backgroundImage: NetworkImage(
                                                leaderdata
                                                        .leaderBoardModel
                                                        .result?[0]
                                                        .profileImg ??
                                                    ""),
                                          ),
                                          Center(
                                            child: Text(
                                              leaderdata.leaderBoardModel
                                                      .result?[0].fullname ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Image.asset(
                                                    "assets/images/ic_icons.png"),
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                leaderdata.leaderBoardModel
                                                        .result?[0].totalScore
                                                        .toString() ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 80),
                                          Text(
                                            "#3",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          const CircleAvatar(
                                            radius: 40,
                                            backgroundColor: primary,
                                            backgroundImage: NetworkImage(""),
                                          ),
                                          Center(
                                            child: Text(
                                              "",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Image.asset(
                                                    "assets/images/ic_icons.png"),
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                "",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            (leaderdata.leaderBoardModel.result?.length ?? 0) >
                                    2
                                ? Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 80),
                                          Text(
                                            "#3",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: primary,
                                            backgroundImage: NetworkImage(
                                                leaderdata
                                                        .leaderBoardModel
                                                        .result?[2]
                                                        .profileImg ??
                                                    ""),
                                          ),
                                          Center(
                                            child: Text(
                                              leaderdata.leaderBoardModel
                                                      .result?[2].fullname ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Image.asset(
                                                    "assets/images/ic_icons.png"),
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                leaderdata.leaderBoardModel
                                                        .result?[2].totalScore
                                                        .toString() ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 80),
                                          Text(
                                            "#3",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          const CircleAvatar(
                                            radius: 40,
                                            backgroundColor: primary,
                                            backgroundImage: NetworkImage(""),
                                          ),
                                          Center(
                                            child: Text(
                                              "",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Image.asset(
                                                    "assets/images/ic_icons.png"),
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                "",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16),
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
                  );
                },
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
          child: Consumer<ApiProvider>(
            builder: (context, leaderdata, child) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                itemCount: (leaderdata.leaderBoardModel.result?.length ?? 0),
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
                        CircleAvatar(
                            minRadius: 25,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(leaderdata
                                    .leaderBoardModel
                                    .result?[index]
                                    .profileImg ??
                                "")),
                        const SizedBox(width: 10),
                        Text(
                          leaderdata.leaderBoardModel.result?[index].fullname ??
                              "",
                          style: const TextStyle(color: black),
                        ),
                        const Spacer(),
                        SizedBox(
                          child: Image.asset("assets/images/ic_icons.png"),
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          leaderdata.leaderBoardModel.result?[index].totalScore
                                  .toString() ??
                              "",
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
              borderRadius: const BorderRadius.all(Radius.circular(40))),
          height: 60,
          child: Consumer<ApiProvider>(
            builder: (context, userdata, child) {
              return Row(
                children: [
                  const SizedBox(width: 15),
                  Text("1",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 16)),
                  const SizedBox(width: 15),
                  CircleAvatar(
                      minRadius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          userdata.leaderBoardModel.user?[0].profileImg ?? "")),
                  const SizedBox(width: 10),
                  MyText(
                      title: userdata.leaderBoardModel.user?[0].fullname ?? ""),
                  const Spacer(),
                  SizedBox(
                    child: Image.asset("assets/images/ic_icons.png"),
                    height: 30,
                    width: 30,
                  ),
                  MyText(
                    title: userdata.leaderBoardModel.user?[0].totalScore
                            .toString() ??
                        "",
                    colors: black,
                    size: 16,
                  ),
                  const SizedBox(width: 15),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
