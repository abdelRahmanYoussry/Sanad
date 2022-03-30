import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/widget/CustomAppbar.dart';
import 'package:quizapp/widget/CustomText.dart';

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
    return const CustomAppbar(
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
                      CustomText(
                          title: 'Upcoming',
                          size: 16,
                          fontWeight: FontWeight.w500),
                      CustomText(
                          title: 'Live', size: 16, fontWeight: FontWeight.w500),
                      CustomText(
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
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            height: 200,
            decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(children: [
              Row(
                children: [
                  Column(
                    children: [
                      CustomText(
                          title: "Prize Pool",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          colors: textColorGrey),
                      CustomText(
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
                      child: CustomText(
                        title: ' Join Now ',
                        size: 16,
                        fontWeight: FontWeight.w500,
                        colors: white,
                      )),
                ],
              )
            ]),
          ),
        );
      },
    );
  }

  live() {
    return Container();
  }

  ended() {
    return Container();
  }
}
