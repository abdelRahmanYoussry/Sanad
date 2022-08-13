import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/widget/MyAppbar.dart';
import 'package:quizapp/widget/myText.dart';
import 'package:shimmer/shimmer.dart';

class Contest extends StatefulWidget {
  const Contest({Key? key}) : super(key: key);

  @override
  _ContestState createState() => _ContestState();
}

class _ContestState extends State<Contest> {
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

    final upcomingdata = Provider.of<ApiProvider>(context, listen: false);
    upcomingdata.getUpContent(context, 'upcoming', userId.toString());
    upcomingdata.getLiveContent(context, 'live', userId.toString());
    upcomingdata.getEndContent(context, 'ended', userId.toString());
  }

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
    return Consumer<ApiProvider>(
      builder: (context, upcomingdata, child) {
        return upcomingdata.loading
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: upcomingdata.upcontentModel.result?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 5, top: 10, right: 5, bottom: 5),
                    height: 220,
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 20, bottom: 10),
                      child: Column(children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                MyText(
                                    title: 'Prize Pool',
                                    size: 16,
                                    fontWeight: FontWeight.w400,
                                    colors: textColorGrey),
                                MyText(
                                    title: upcomingdata.upcontentModel
                                            .result?[index].totalPrize
                                            .toString() ??
                                        "",
                                    size: 24,
                                    fontWeight: FontWeight.w600,
                                    colors: black)
                              ],
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(28.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all(appColor)),
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
                              height: 15,
                              width: 15,
                            ),
                            const SizedBox(width: 5),
                            MyText(
                                title:
                                    'WINNERS: ${upcomingdata.upcontentModel.result?[index].noOfUserPrize ?? ""}',
                                size: 16,
                                fontWeight: FontWeight.w400,
                                colors: textColorGree),
                            const Spacer(),
                            MyText(
                                title: upcomingdata
                                        .upcontentModel.result?[index].name ??
                                    "",
                                size: 16,
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
                                title:
                                    "${upcomingdata.upcontentModel.result?[index].noOfUser ?? ""} Total",
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
                                title: "5h 40m",
                                size: 16,
                                fontWeight: FontWeight.w600),
                            const Spacer(),
                            MyText(
                                title:
                                    "Entry Fee: ${upcomingdata.upcontentModel.result?[index].price ?? ""}",
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
      },
    );
  }

  live() {
    return Consumer<ApiProvider>(
      builder: (context, livecontent, child) {
        return livecontent.loading
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: livecontent.livecontentModel.result?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 5, top: 10, right: 5, bottom: 5),
                    height: 200,
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
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
                                    title: livecontent.livecontentModel
                                            .result?[index].totalPrize
                                            .toString() ??
                                        "",
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
                              height: 15,
                              width: 15,
                            ),
                            const SizedBox(width: 5),
                            MyText(
                                title: "WINNERS: 20",
                                size: 16,
                                fontWeight: FontWeight.w400,
                                colors: textColorGree),
                            const Spacer(),
                            MyText(
                                title: livecontent
                                        .livecontentModel.result?[index].name ??
                                    "",
                                size: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                maxline: 1,
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
                                title:
                                    "${livecontent.livecontentModel.result?[index].noOfUser} Total",
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
                                title: "5h 40m",
                                size: 16,
                                fontWeight: FontWeight.w600),
                            const Spacer(),
                            MyText(
                                title:
                                    "Entry Fee: ${livecontent.livecontentModel.result?[index].price}",
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
      },
    );
  }

  ended() {
    return Consumer<ApiProvider>(
      builder: (context, endcontent, child) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: endcontent.endcontentModel.result?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              margin:
                  const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
              height: 165,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
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
                              title: endcontent
                                      .endcontentModel.result?[index].totalPrize
                                      .toString() ??
                                  "",
                              size: 24,
                              textalign: TextAlign.left,
                              fontWeight: FontWeight.w600,
                              colors: black)
                        ],
                      ),
                      const Spacer(),
                      MyText(
                          title:
                              "Entry Fee: ${endcontent.endcontentModel.result?[index].price}",
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
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(width: 5),
                      MyText(
                          title: "WINNERS: 20",
                          size: 16,
                          fontWeight: FontWeight.w400,
                          colors: textColorGree),
                      const Spacer(),
                      MyText(
                          title:
                              endcontent.endcontentModel.result?[index].name ??
                                  "",
                          size: 18,
                          fontWeight: FontWeight.w600,
                          colors: black)
                    ],
                  ),
                  const SizedBox(height: 20),
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
      },
    );
  }
}
