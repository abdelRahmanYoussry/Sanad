import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/widget/mynetimage.dart';
import 'package:quizapp/widget/mytext.dart';

class LevelResult extends StatefulWidget {
  final levelId;
  const LevelResult({Key? key, required this.levelId}) : super(key: key);

  @override
  State<LevelResult> createState() => _LevelResultState();
}

class _LevelResultState extends State<LevelResult> {
  SharePref sharePref = SharePref();
  String? userId;
  @override
  initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');
    debugPrint('LevelID===>${widget.levelId.toString()}');

    final levelData = Provider.of<ApiProvider>(context, listen: false);
    levelData.getTodayLeaderBoard(context, userId, widget.levelId);
  }

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
                          child: Consumer<ApiProvider>(
                            builder: (context, userdata, child) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    title: userdata.todayLeaderBoardModel.user
                                                ?.isUnlock ==
                                            1
                                        ? "Congratulations!\nYou have completed level."
                                        : "Sorry, Try again!\nYou have not completed level",
                                    size: 18,
                                    fontWeight: FontWeight.w500,
                                    colors: white,
                                    textalign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: primary,
                                    backgroundImage: NetworkImage(userdata
                                            .todayLeaderBoardModel
                                            .user
                                            ?.profileImg ??
                                        ""),
                                  ),
                                  Center(
                                    child: MyText(
                                      title: userdata.todayLeaderBoardModel.user
                                              ?.fullname ??
                                          "",
                                      size: 16,
                                      fontWeight: FontWeight.w500,
                                      colors: white,
                                      textalign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  MyText(
                                    title:
                                        "${userdata.todayLeaderBoardModel.user?.score} Points Earned.",
                                    fontWeight: FontWeight.w500,
                                    colors: white,
                                    size: 18,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
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
                                                              BorderRadius
                                                                  .circular(
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
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          side: const BorderSide(
                                                              color: white))))),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildBody(),
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
          child: Consumer<ApiProvider>(
            builder: (context, todaydata, child) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                itemCount: todaydata.todayLeaderBoardModel.result?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        Text((index + 1).toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 16)),
                        const SizedBox(width: 15),
                        CircleAvatar(
                            minRadius: 25,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                '${todaydata.todayLeaderBoardModel.result?[index].profileImg}')),
                        const SizedBox(width: 10),
                        Text(
                          todaydata.todayLeaderBoardModel.result?[index]
                                  .fullname ??
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
                          (todaydata.todayLeaderBoardModel.result?[index]
                                      .userTotalScore ??
                                  0)
                              .toString(),
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
}
