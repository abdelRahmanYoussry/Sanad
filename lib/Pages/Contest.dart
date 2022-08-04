import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/widget/MyAppbar.dart';
import 'package:quizapp/widget/myText.dart';

class Contest extends StatefulWidget {
  const Contest({Key? key}) : super(key: key);

  @override
  _ContestState createState() => _ContestState();
}

class _ContestState extends State<Contest> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  getAppbar() {
    return const MyAppbar(
      title: "Contest",
    );
  }

  buildBody() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                getAppbar(),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: tabbarunselect,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(25.0)),
                    labelColor: appColor,
                    unselectedLabelColor: white,
                    tabs: [
                      MyText(
                          title: 'Upcoming',
                          size: 16,
                          fontWeight: FontWeight.w500),
                      MyText(
                          title: 'Live', size: 16, fontWeight: FontWeight.w500),
                      MyText(
                          title: 'Ended', size: 16, fontWeight: FontWeight.w500)
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [upcoming(), live(), ended()],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  upcoming() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
          height: 220,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: Column(children: [
              Row(
                children: [
                  Column(
                    children: [
                      MyText(
                          title: "Prize Pool",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          colors: textColorGrey),
                      MyText(
                          title: "5000",
                          size: 24,
                          fontWeight: FontWeight.w600,
                          colors: black)
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28.0))),
                          backgroundColor: MaterialStateProperty.all(appColor)),
                      child: MyText(
                        title: ' Join Now ',
                        size: 16,
                        fontWeight: FontWeight.w500,
                        colors: white,
                      )),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Image.asset(
                    "assets/images/ic_trophy.png",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 10),
                  MyText(
                      title: "WINNERS: 20",
                      size: 18,
                      fontWeight: FontWeight.w400,
                      colors: textColorGree),
                  const Spacer(),
                  MyText(
                      title: "Quiz Contest",
                      size: 18,
                      fontWeight: FontWeight.w600,
                      colors: black)
                ],
              ),
              const SizedBox(height: 10),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 5,
                animationDuration: 2500,
                percent: 0.8,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: appColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                      title: "150 Left",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: red),
                  const Spacer(),
                  MyText(
                      title: "500 Total",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: textColorGrey),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(height: 0.5, color: textColorGrey),
              const SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                      title: "5h 40m", size: 16, fontWeight: FontWeight.w600),
                  const Spacer(),
                  MyText(
                      title: "Entry Fee: 50",
                      size: 16,
                      fontWeight: FontWeight.w600),
                  const Spacer(),
                  MyText(
                      title: "Winner Details",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: appColor),
                ],
              )
            ]),
          ),
        );
      },
    );
  }

  live() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
          height: 220,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: Column(children: [
              Row(
                children: [
                  Column(
                    children: [
                      MyText(
                          title: "Prize Pool",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          colors: textColorGrey),
                      MyText(
                          title: "5000",
                          size: 24,
                          fontWeight: FontWeight.w600,
                          colors: black)
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Image.asset(
                    "assets/images/ic_trophy.png",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 10),
                  MyText(
                      title: "WINNERS: 20",
                      size: 18,
                      fontWeight: FontWeight.w400,
                      colors: textColorGree),
                  const Spacer(),
                  MyText(
                      title: "Quiz Contest",
                      size: 18,
                      fontWeight: FontWeight.w600,
                      colors: black)
                ],
              ),
              const SizedBox(height: 10),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 5,
                animationDuration: 2500,
                percent: 0.8,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: appColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                      title: "150 Left",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: red),
                  const Spacer(),
                  MyText(
                      title: "500 Total",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: textColorGrey),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(height: 0.5, color: textColorGrey),
              const SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                      title: "5h 40m", size: 16, fontWeight: FontWeight.w600),
                  const Spacer(),
                  MyText(
                      title: "Entry Fee: 50",
                      size: 16,
                      fontWeight: FontWeight.w600),
                  const Spacer(),
                  MyText(
                      title: "Winner Details",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: appColor),
                ],
              )
            ]),
          ),
        );
      },
    );
  }

  ended() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
          height: 200,
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: Column(children: [
              Row(
                children: [
                  Column(
                    children: [
                      MyText(
                          title: "Prize Pool",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          colors: textColorGrey),
                      MyText(
                          title: "5000",
                          size: 24,
                          fontWeight: FontWeight.w600,
                          colors: black)
                    ],
                  ),
                  const Spacer(),
                  MyText(
                      title: "Entry Fee: 99",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: black),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Image.asset(
                    "assets/images/ic_trophy.png",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 10),
                  MyText(
                      title: "WINNERS: 20",
                      size: 18,
                      fontWeight: FontWeight.w400,
                      colors: textColorGree),
                  const Spacer(),
                  MyText(
                      title: "Quiz Contest",
                      size: 18,
                      fontWeight: FontWeight.w600,
                      colors: black)
                ],
              ),
              const SizedBox(height: 10),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 5,
                animationDuration: 2500,
                percent: 0.8,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: appColor,
              ),
              const SizedBox(height: 25),
              const Divider(height: 0.2, color: textColorGrey),
              const SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                      title: "Leaderboard",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: appColor),
                  const Spacer(),
                  MyText(
                      title: "Statistics",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: appColor),
                  const Spacer(),
                  MyText(
                      title: "Winner Details",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      colors: appColor),
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
