import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sanad/pages/calenderPage/calenderScreen.dart';
import 'package:sanad/pages/contest/contestleaderboard.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/theme/color.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/utils/utility.dart';
import 'package:sanad/widget/MyAppbar.dart';
import 'package:sanad/widget/myimage.dart';
import 'package:sanad/widget/mytext.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class Contest extends StatefulWidget {
  const Contest({
    Key? key,
  }) : super(key: key);

  @override
  _ContestState createState() => _ContestState();
}

class _ContestState extends State<Contest> {
  SharePref sharePref = SharePref();
  String? userId;
  var bannerad = "";
  var banneradIos = "";
  double? totalCoins;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Duration _differenceDay = const Duration(days: 0);
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  // int index = 0;
  // ContestQuestionModel example=ContestQuestionModel();
  @override
  initState() {
    getUserId();
    // getTotalCoins();
    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID _Contest ===>${userId.toString()}');
    bannerad = await sharePref.read("banner_ad") ?? "";
    banneradIos = await sharePref.read("ios_banner_ad") ?? "";

    final upcomingdata = Provider.of<ApiProvider>(context, listen: false);
    upcomingdata.getUpContent(context, 'upcoming', userId.toString());
    upcomingdata.getLiveContent(context, 'live', userId.toString());
    upcomingdata.getEndContent(context, 'ended', userId.toString());
    upcomingdata.getQuestionByContest(context, 14.toString());

    upcomingdata.getProfile(context, userId);
    totalCoins = double.parse(upcomingdata.profileModel.result![0].totalCoins!);
    debugPrint('TotalCoins==========> $totalCoins');

    // upcomingdata.getQuestionByContestTest(context, 14.toString());
    // final example = upcomingdata.contestQuestionModelNew;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, child, live) {
        return buildBody();
      },
    );
  }

  getAppbar() {
    return const MyAppbar(
      title: "Challenges",
    );
  }

  buildBody() {
    return DefaultTabController(
      length: 2,
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
                // const SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: tabbarunselect,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20.0)),
                    labelColor: appColor,
                    unselectedLabelColor: white,
                    tabs: [
                      MyText(
                          title: 'Upcoming',
                          size: 16,
                          fontWeight: FontWeight.w500),
                      MyText(
                          title: 'Live', size: 16, fontWeight: FontWeight.w500),
                      // MyText(
                      //     title: 'Ended', size: 16, fontWeight: FontWeight.w500)
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    upcoming(), live()
                    // , ended()
                  ],
                )),
                // SizedBox(
                //   height: 50,
                //   child: AdWidget(
                //       ad: AdHelper.createBannerAd()..load(), key: UniqueKey()),
                // ),
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
                  DateTime date1 = DateTime.parse(
                      (upcomingdata.upcontentModel.result?[index].startDate ??
                          ""));
                  DateTime now = DateTime.now();
                  debugPrint(now.toString());
                  debugPrint(date1.toString());

                  Duration diff = date1.difference(now);

                  debugPrint('===> ${diff.inDays}');

                  return Container(
                    margin: const EdgeInsets.only(
                        left: 5, top: 10, right: 5, bottom: 5),
                    height: MediaQuery.of(context).size.height / 4,
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
                          // linearStrokeCap: LinearStrokeCap.roundAll,
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
                        const Spacer(),
                        // const SizedBox(height: 10),
                        // const Divider(height: 0.5, color: textColorGrey),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                Utility.customShowDialog(
                                    title: Center(
                                      child: Text(upcomingdata
                                          .upcontentModel.result![index].name!),
                                    ),
                                    content: SizedBox(
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: MyText(
                                                      title: 'Start :',
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Expanded(
                                                  child: MyText(
                                                      title: diff.inDays > 1
                                                          ? Utility().dateConvert(
                                                              upcomingdata
                                                                      .upcontentModel
                                                                      .result?[
                                                                          index]
                                                                      .startDate ??
                                                                  "",
                                                              "dd-MMM-yy")
                                                          : diff.inHours
                                                                  .toString() +
                                                              " h - " +
                                                              diff.inMinutes
                                                                  .toString() +
                                                              " m - " +
                                                              diff.inSeconds
                                                                  .toString() +
                                                              " m - ",
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const VerticalDivider(
                                            thickness: 1,
                                            width: 1,
                                            color: textColorGrey,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: MyText(
                                                      title: 'Entry Fee :',
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Expanded(
                                                  child: MyText(
                                                      title:
                                                          "${upcomingdata.upcontentModel.result?[index].price! ?? ""} +' Coins'",
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const VerticalDivider(
                                            thickness: 1,
                                            width: 1,
                                            color: textColorGrey,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: MyText(
                                                      title: 'End :',
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Expanded(
                                                  child: MyText(
                                                      title: Utility().dateConvert(
                                                          upcomingdata
                                                                  .upcontentModel
                                                                  .result?[
                                                                      index]
                                                                  .endDate ??
                                                              "",
                                                          "dd-MMM-yy"),
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(
                                              color: baseColor, fontSize: 20),
                                        ),
                                      ),
                                      (upcomingdata.upcontentModel
                                                      .result?[index].isBuy ??
                                                  0) ==
                                              0
                                          ? TextButton(
                                              onPressed: () async {
                                                final joinContest =
                                                    Provider.of<ApiProvider>(
                                                        context,
                                                        listen: false);
                                                await joinContest
                                                    .getjoinContest(
                                                        context,
                                                        upcomingdata
                                                                .upcontentModel
                                                                .result?[index]
                                                                .id
                                                                .toString() ??
                                                            "",
                                                        userId.toString(),
                                                        upcomingdata
                                                                .upcontentModel
                                                                .result?[index]
                                                                .price
                                                                .toString() ??
                                                            "");
                                                if (!joinContest.loading) {
                                                  Utility.toastMessage(
                                                      joinContest
                                                          .successModel.message
                                                          .toString());
                                                }
                                              },
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      28.0))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          appColor)),
                                              child: MyText(
                                                title: ' Join Now ',
                                                size: 16,
                                                fontWeight: FontWeight.w500,
                                                colors: white,
                                              ))
                                          : Container(),
                                    ],
                                    context: context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(cyan),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ]),
                    ),
                  );
                },
              );
      },
    );
  }

  // getTotalCoins() async {
  //   totalCoins = await sharePref.read('totalCoins');
  //   debugPrint('totalCoins===>${totalCoins.toString()}');
  // }

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
                        height: 160,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  );
                },
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount:
                          livecontent.livecontentModel.result?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 5, top: 10, right: 5, bottom: 0),
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: const BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10, bottom: 5),
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
                                  (livecontent.livecontentModel.result?[index]
                                                  .isPlayed ??
                                              0) ==
                                          0
                                      ? TextButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28.0))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      appColor)),
                                          child: MyText(
                                            title: ' Join Now ',
                                            size: 16,
                                            fontWeight: FontWeight.w500,
                                            colors: white,
                                          ),
                                          onPressed: () async {
                                            await livecontent
                                                .getQuestionByContest(
                                                    context,
                                                    livecontent.livecontentModel
                                                        .result![index].id
                                                        .toString());
                                            Utility.customShowDialog(
                                                title: Center(
                                                  child: Text(livecontent
                                                      .livecontentModel
                                                      .result![index]
                                                      .name!),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        MyText(
                                                            title: "5h 40m",
                                                            size: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        const VerticalDivider(
                                                          thickness: 2,
                                                          width: 20,
                                                          color: textColorGrey,
                                                        ),
                                                        MyText(
                                                            title:
                                                                "Entry Fee: ${livecontent.livecontentModel.result?[index].price} Coin",
                                                            size: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      'Are you Sure to Join Now?',
                                                      style: TextStyle(
                                                          color: actionColor),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: baseColor,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(cyan),
                                                        shape: MaterialStateProperty.all(
                                                            const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            28.0))))),
                                                    onPressed: () async {
                                                      if (totalCoins! >=
                                                          int.parse(livecontent
                                                              .livecontentModel
                                                              .result![index]
                                                              .price!)) {
                                                        if (livecontent
                                                            .contestQuestionModel
                                                            .result!
                                                            .isEmpty) {
                                                          Utility.toastMessage(
                                                              ' Challenge is Coming Soon');
                                                        } else {
                                                          totalCoins = totalCoins! -
                                                              int.parse((livecontent
                                                                  .livecontentModel
                                                                  .result?[
                                                                      index]
                                                                  .price)!);
                                                          livecontent.updateCoinsAndPoints(
                                                              userId: userId!
                                                                  .toString(),
                                                              coins: totalCoins!
                                                                  .toInt(),
                                                              context: context);
                                                          Navigator
                                                              .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          CalenderScreen(
                                                                            questionId:
                                                                                (livecontent.livecontentModel.result?[index].id.toString())!,
                                                                            contestName:
                                                                                (livecontent.livecontentModel.result?[index].name)!,
                                                                          )));
                                                        }
                                                      } else if (totalCoins! <
                                                          int.parse(livecontent
                                                              .livecontentModel
                                                              .result![index]
                                                              .price!)) {
                                                        Utility.toastMessage(
                                                            ' You have $totalCoins coin \n '
                                                            'Please recharge your wallet');
                                                      } else {
                                                        Utility.toastMessage(
                                                            ' You have $totalCoins coin \n '
                                                            'Please recharge your wallet');
                                                      }
                                                    },
                                                  ),
                                                ],
                                                context: context);
                                          },
                                        )
                                      : MyText(
                                          title: 'Already Played',
                                          fontWeight: FontWeight.w500,
                                          colors: red,
                                          size: 14,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                                          "WINNERS: ${livecontent.livecontentModel.result?[index].noOfUserPrize}",
                                      size: 16,
                                      fontWeight: FontWeight.w400,
                                      colors: textColorGree),
                                  const Spacer(),
                                  MyText(
                                      title: livecontent.livecontentModel
                                              .result?[index].name ??
                                          "",
                                      size: 16,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      maxline: 1,
                                      colors: black)
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 1, color: textColorGrey),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(
                                        title: "5h 40m",
                                        size: 16,
                                        fontWeight: FontWeight.w600),
                                    const VerticalDivider(
                                      thickness: 2,
                                      width: 20,
                                      color: textColorGrey,
                                    ),
                                    MyText(
                                        title:
                                            "Entry Fee: ${livecontent.livecontentModel.result?[index].price}",
                                        size: 16,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Utility.customShowDialog(
                                          title: const Center(
                                              child: Text('Details')),
                                          content: Text(livecontent
                                              .livecontentModel
                                              .result![index]
                                              .name!),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: cyan, fontSize: 20),
                                              ),
                                            )
                                          ],
                                          context: context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(cyan),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Description',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       left: 5, top: 10, right: 5, bottom: 0),
                  //   height: MediaQuery.of(context).size.height / 4,
                  //   decoration: BoxDecoration(
                  //       color: Colors.black.withOpacity(0.5),
                  //       borderRadius:
                  //           const BorderRadius.all(Radius.circular(20))),
                  //   child: Container(
                  //     padding: const EdgeInsets.only(
                  //         left: 10, top: 10, right: 10, bottom: 5),
                  //     child: Column(children: [
                  //       Row(
                  //         children: [
                  //           Column(
                  //             children: [
                  //               MyText(
                  //                   title: "Prize Pool",
                  //                   size: 16,
                  //                   fontWeight: FontWeight.w400,
                  //                   colors: Colors.white),
                  //               MyText(
                  //                   title: livecontent.livecontentModel
                  //                           .result?[2].totalPrize
                  //                           .toString() ??
                  //                       "",
                  //                   size: 24,
                  //                   fontWeight: FontWeight.w600,
                  //                   colors: Colors.white)
                  //             ],
                  //           ),
                  //           const Spacer(),
                  //           (livecontent.livecontentModel.result?[2].isPlayed ??
                  //                       0) ==
                  //                   0
                  //               ? TextButton(
                  //                   onPressed: () {
                  //                     Utility.customShowDialog(
                  //                         title: Center(
                  //                           child: Text(livecontent
                  //                               .livecontentModel
                  //                               .result![2]
                  //                               .name!),
                  //                         ),
                  //                         content: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             Row(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.center,
                  //                               children: [
                  //                                 MyText(
                  //                                     title: "5h 40m",
                  //                                     size: 16,
                  //                                     fontWeight:
                  //                                         FontWeight.w600),
                  //                                 const VerticalDivider(
                  //                                   thickness: 2,
                  //                                   width: 20,
                  //                                   color: textColorGrey,
                  //                                 ),
                  //                                 MyText(
                  //                                     title:
                  //                                         "Entry Fee: ${livecontent.livecontentModel.result?[2].price} Coin",
                  //                                     size: 16,
                  //                                     fontWeight:
                  //                                         FontWeight.w600),
                  //                               ],
                  //                             ),
                  //                             const SizedBox(
                  //                               height: 10,
                  //                             ),
                  //                             const Text(
                  //                               'Are you Sure to Join Now?',
                  //                               style: TextStyle(
                  //                                   color: actionColor),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         actions: [
                  //                           TextButton(
                  //                             onPressed: () {
                  //                               Navigator.pop(context);
                  //                             },
                  //                             child: const Text(
                  //                               'Cancel',
                  //                               style: TextStyle(
                  //                                   color: baseColor,
                  //                                   fontSize: 20),
                  //                             ),
                  //                           ),
                  //                           TextButton(
                  //                             style: ButtonStyle(
                  //                                 backgroundColor:
                  //                                     MaterialStateProperty.all(
                  //                                         cyan),
                  //                                 shape: MaterialStateProperty.all(
                  //                                     const RoundedRectangleBorder(
                  //                                         borderRadius:
                  //                                             BorderRadius.all(
                  //                                                 Radius.circular(
                  //                                                     28.0))))),
                  //                             onPressed: () async {
                  //                               if (totalCoins! >=
                  //                                   int.parse(livecontent
                  //                                       .livecontentModel
                  //                                       .result![2]
                  //                                       .price!)) {
                  //                                 totalCoins = totalCoins! -
                  //                                     int.parse((livecontent
                  //                                         .livecontentModel
                  //                                         .result?[2]
                  //                                         .price)!);
                  //                                 livecontent
                  //                                     .updateCoinsAndPoints(
                  //                                         userId: userId!
                  //                                             .toString(),
                  //                                         coins: totalCoins!
                  //                                             .toInt(),
                  //                                         context: context);
                  //
                  //                                 Navigator.pushReplacement(
                  //                                     context,
                  //                                     MaterialPageRoute(
                  //                                         builder: (context) =>
                  //                                             CalenderScreen(
                  //                                               questionId:
                  //                                                   '14',
                  //                                               contestName:
                  //                                                   (livecontent
                  //                                                       .livecontentModel
                  //                                                       .result?[
                  //                                                           2]
                  //                                                       .name)!,
                  //                                             )
                  //                                         // ContestQuestions(
                  //                                         //   contestId: livecontent.livecontentModel.result?[index].id.toString(),
                  //                                         //   contestName: livecontent.livecontentModel.result?[index].name,
                  //                                         // )
                  //                                         ));
                  //                               } else {
                  //                                 Utility.toastMessage(
                  //                                     ' You have $totalCoins coin \n '
                  //                                     'Please recharge your wallet');
                  //                               }
                  //                             },
                  //                             child: const Text(
                  //                               'Confirm',
                  //                               style: TextStyle(
                  //                                   color: Colors.white),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                         context: context);
                  //
                  //                     // if (totalCoins! >=
                  //                     //     int.parse(livecontent.livecontentModel
                  //                     //         .result![2].price!)) {
                  //                     //   totalCoins = totalCoins! -
                  //                     //       int.parse((livecontent
                  //                     //           .livecontentModel
                  //                     //           .result?[2]
                  //                     //           .price)!);
                  //                     //   livecontent.updateCoinsAndPoints(
                  //                     //       userId: userId!.toString(),
                  //                     //       coins: totalCoins!.toInt(),
                  //                     //       context: context);
                  //                     //
                  //                     //   Navigator.pushReplacement(
                  //                     //       context,
                  //                     //       MaterialPageRoute(
                  //                     //           builder: (context) =>
                  //                     //               CalenderScreen(
                  //                     //                 questionId: '14',
                  //                     //               )));
                  //                     // } else {
                  //                     //   Utility.toastMessage(
                  //                     //       ' You have $totalCoins coin \n '
                  //                     //       'Please recharge your wallet');
                  //                     // }
                  //
                  //                     // showDialog(
                  //                     //     context: context,
                  //                     //     builder: (context) {
                  //                     //       return StatefulBuilder(
                  //                     //           builder: (context, setState2) {
                  //                     //         return AlertDialog(
                  //                     //           actionsAlignment:
                  //                     //               MainAxisAlignment.start,
                  //                     //           content: Column(
                  //                     //             mainAxisSize:
                  //                     //                 MainAxisSize.min,
                  //                     //             children: [
                  //                     //               SizedBox(
                  //                     //                 height: 200,
                  //                     //                 width: 400,
                  //                     //                 // color:
                  //                     //                 //     cyan.withOpacity(0.5),
                  //                     //                 child: TableCalendar(
                  //                     //                   calendarFormat:
                  //                     //                       CalendarFormat
                  //                     //                           .month,
                  //                     //                   // eventLoader:
                  //                     //                   //     (DateTime day) {
                  //                     //                   //   // return List<_>;
                  //                     //                   // },
                  //                     //                   rowHeight: 25,
                  //                     //                   headerStyle:
                  //                     //                       const HeaderStyle(
                  //                     //                     formatButtonVisible:
                  //                     //                         false,
                  //                     //                     titleCentered: true,
                  //                     //                   ),
                  //                     //                   calendarStyle:
                  //                     //                       CalendarStyle(
                  //                     //                           rangeHighlightColor:
                  //                     //                               cyan.withOpacity(
                  //                     //                                   0.2),
                  //                     //                           rangeStartDecoration:
                  //                     //                               const BoxDecoration(
                  //                     //                                   color:
                  //                     //                                       cyan),
                  //                     //                           rangeEndDecoration:
                  //                     //                               const BoxDecoration(
                  //                     //                                   color:
                  //                     //                                       cyan),
                  //                     //                           selectedDecoration:
                  //                     //                               const BoxDecoration(
                  //                     //                             color:
                  //                     //                                 appColor,
                  //                     //                             shape: BoxShape
                  //                     //                                 .circle,
                  //                     //                           )),
                  //                     //                   selectedDayPredicate:
                  //                     //                       (day) => isSameDay(
                  //                     //                           _selectedDay,
                  //                     //                           day),
                  //                     //                   firstDay: DateTime(
                  //                     //                       2022, 1, 1),
                  //                     //                   lastDay: DateTime(
                  //                     //                       2200, 1, 1),
                  //                     //                   focusedDay: _focusedDay,
                  //                     //                   rangeSelectionMode:
                  //                     //                       _rangeSelectionMode,
                  //                     //                   onFormatChanged:
                  //                     //                       (calenderFormat) {},
                  //                     //                   onDaySelected:
                  //                     //                       (selectedDay,
                  //                     //                           focusedDay) {
                  //                     //                     if (!isSameDay(
                  //                     //                         _selectedDay,
                  //                     //                         selectedDay)) {
                  //                     //                       setState2(() {
                  //                     //                         _selectedDay =
                  //                     //                             selectedDay;
                  //                     //                         _focusedDay =
                  //                     //                             focusedDay;
                  //                     //                         _rangeSelectionMode =
                  //                     //                             RangeSelectionMode
                  //                     //                                 .toggledOff;
                  //                     //                         if (index <=
                  //                     //                             livecontent
                  //                     //                                 .contestQuestionModelNew
                  //                     //                                 .result!
                  //                     //                                 .length) {
                  //                     //                           index =
                  //                     //                               index + 1;
                  //                     //                           debugPrint(livecontent
                  //                     //                               .contestQuestionModelNew
                  //                     //                               .result!
                  //                     //                               .length.toString());
                  //                     //                           debugPrint(index
                  //                     //                                   .toString() +
                  //                     //                               'index');
                  //                     //                         }
                  //                     //                         if (index ==
                  //                     //                             livecontent
                  //                     //                                 .contestQuestionModelNew
                  //                     //                                 .result!
                  //                     //                                 .length) {
                  //                     //                           index = 0;
                  //                     //                         }
                  //                     //                         _differenceDay =
                  //                     //                             _selectedDay!
                  //                     //                                 .difference(
                  //                     //                                     DateTime
                  //                     //                                         .now());
                  //                     //                         debugPrint(_differenceDay
                  //                     //                                 .inDays
                  //                     //                                 .toString() +
                  //                     //                             'diff');
                  //                     //                         debugPrint(_focusedDay
                  //                     //                                 .day
                  //                     //                                 .toString() +
                  //                     //                             'this is focused');
                  //                     //                         debugPrint(_selectedDay!
                  //                     //                                 .day
                  //                     //                                 .toString() +
                  //                     //                             'this is _selectedDay');
                  //                     //                       });
                  //                     //                     }
                  //                     //                   },
                  //                     //                   rangeStartDay:
                  //                     //                       DateTime.now(),
                  //                     //                   rangeEndDay: DateTime
                  //                     //                           .now()
                  //                     //                       .add(Duration(
                  //                     //                           days: livecontent
                  //                     //                               .contestQuestionModel
                  //                     //                               .result!
                  //                     //                               .length)),
                  //                     //                 ),
                  //                     //               ),
                  //                     //               const Text('Question'),
                  //                     //               Text(
                  //                     //                 livecontent
                  //                     //                     .contestQuestionModelNew
                  //                     //                     .result![index]
                  //                     //                     .question!,
                  //                     //                 maxLines: 2,
                  //                     //                 overflow:
                  //                     //                     TextOverflow.ellipsis,
                  //                     //               )
                  //                     //             ],
                  //                     //           ),
                  //                     //           actions: [
                  //                     //             Row(
                  //                     //               children: [
                  //                     //                 TextButton(
                  //                     //                   onPressed: () {
                  //                     //                     Navigator.pop(
                  //                     //                         context);
                  //                     //                   },
                  //                     //                   child: const Text(
                  //                     //                     'Cancel',
                  //                     //                     style: TextStyle(
                  //                     //                         color: baseColor,
                  //                     //                         fontSize: 20),
                  //                     //                   ),
                  //                     //                 ),
                  //                     //                 TextButton(
                  //                     //                   style: ButtonStyle(
                  //                     //                       backgroundColor:
                  //                     //                           MaterialStateProperty
                  //                     //                               .all(cyan),
                  //                     //                       shape: MaterialStateProperty.all(
                  //                     //                           const RoundedRectangleBorder(
                  //                     //                               borderRadius:
                  //                     //                                   BorderRadius.all(
                  //                     //                                       Radius.circular(28.0))))),
                  //                     //                   onPressed: () async {
                  //                     //                     if (_differenceDay
                  //                     //                             .inDays ==
                  //                     //                         0) {
                  //                     //                       Utility.toastMessage(
                  //                     //                           ' Coming Soon Waiting For Api');
                  //                     //                     } else {
                  //                     //                       Utility.toastMessage(
                  //                     //                           'No Matching With Selected Day \n Please Select '
                  //                     //                           'another question');
                  //                     //                     }
                  //                     //                   },
                  //                     //                   child: const Text(
                  //                     //                     'Confirm',
                  //                     //                     style: TextStyle(
                  //                     //                         color:
                  //                     //                             Colors.white),
                  //                     //                   ),
                  //                     //                 ),
                  //                     //               ],
                  //                     //               mainAxisAlignment:
                  //                     //                   MainAxisAlignment
                  //                     //                       .spaceBetween,
                  //                     //             )
                  //                     //           ],
                  //                     //           shape:
                  //                     //               const RoundedRectangleBorder(
                  //                     //                   borderRadius:
                  //                     //                       BorderRadius.all(
                  //                     //                           Radius.circular(
                  //                     //                               10.0))),
                  //                     //         );
                  //                     //       });
                  //                     //     });
                  //                   },
                  //                   style: ButtonStyle(
                  //                       shape: MaterialStateProperty.all<
                  //                               RoundedRectangleBorder>(
                  //                           RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(
                  //                                       28.0))),
                  //                       backgroundColor:
                  //                           MaterialStateProperty.all(
                  //                               appColor)),
                  //                   child: MyText(
                  //                     title: ' Join Now ',
                  //                     size: 16,
                  //                     fontWeight: FontWeight.w500,
                  //                     colors: white,
                  //                   ))
                  //               : MyText(
                  //                   title: 'Already Played',
                  //                   fontWeight: FontWeight.w500,
                  //                   colors: red,
                  //                   size: 14,
                  //                   maxline: 1,
                  //                   overflow: TextOverflow.ellipsis,
                  //                 ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 15),
                  //       Row(
                  //         children: [
                  //           Image.asset(
                  //             "assets/images/ic_trophy.png",
                  //             height: 15,
                  //             width: 15,
                  //             color: Colors.white,
                  //           ),
                  //           const SizedBox(width: 5),
                  //           MyText(
                  //               title:
                  //                   "WINNERS: ${livecontent.livecontentModel.result?[2].noOfUserPrize}",
                  //               size: 16,
                  //               fontWeight: FontWeight.w400,
                  //               colors: Colors.white),
                  //           const Spacer(),
                  //           MyText(
                  //               title: livecontent
                  //                       .livecontentModel.result?[2].name ??
                  //                   "",
                  //               size: 16,
                  //               fontWeight: FontWeight.w600,
                  //               overflow: TextOverflow.ellipsis,
                  //               maxline: 1,
                  //               colors: Colors.white)
                  //         ],
                  //       ),
                  //       const SizedBox(height: 10),
                  //       const Divider(height: 1, color: Colors.white),
                  //       const SizedBox(height: 10),
                  //       SizedBox(
                  //         height: 25,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             MyText(
                  //                 title: "5h 40m",
                  //                 size: 16,
                  //                 colors: Colors.white,
                  //                 fontWeight: FontWeight.w600),
                  //             const VerticalDivider(
                  //               thickness: 2,
                  //               width: 20,
                  //               color: Colors.white,
                  //             ),
                  //             MyText(
                  //                 title:
                  //                     "Entry Fee: ${livecontent.livecontentModel.result?[2].price}",
                  //                 size: 16,
                  //                 colors: Colors.white,
                  //                 fontWeight: FontWeight.w600),
                  //           ],
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       SizedBox(
                  //         width: double.infinity,
                  //         height: 40,
                  //         child: ElevatedButton(
                  //           style: ButtonStyle(
                  //             backgroundColor: MaterialStateProperty.all(cyan),
                  //             shape: MaterialStateProperty.all(
                  //               RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(28),
                  //               ),
                  //             ),
                  //           ),
                  //           child: const Text(
                  //             'Description',
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 18,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           onPressed: () {
                  //             Utility.customShowDialog(
                  //                 title: const Center(child: Text('Details')),
                  //                 content: Text(livecontent
                  //                     .livecontentModel.result![2].name!),
                  //                 actions: [
                  //                   TextButton(
                  //                     onPressed: () {
                  //                       Navigator.pop(context);
                  //                     },
                  //                     child: const Text(
                  //                       'Ok',
                  //                       style: TextStyle(
                  //                           color: cyan, fontSize: 20),
                  //                     ),
                  //                   )
                  //                 ],
                  //                 context: context);
                  //           },
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 5,
                  //       ),
                  //     ]),
                  //   ),
                  // )
                ],
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
              height: 160,
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
                          title:
                              "WINNERS: ${endcontent.endcontentModel.result?[index].noOfUserPrize.toString() ?? ""}",
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
                  const SizedBox(height: 15),
                  const Divider(height: 0.2, color: textColorGrey),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContestLeaderBoard(
                                        contestId: endcontent
                                            .endcontentModel.result?[index].id,
                                      )));
                        },
                        child: MyText(
                            title: "Leaderboard",
                            size: 16,
                            fontWeight: FontWeight.w600,
                            colors: appColor),
                      ),
                      const Spacer(),
                      MyText(
                          title: "Statistics",
                          size: 16,
                          fontWeight: FontWeight.w600,
                          colors: appColor),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          winnerList(
                              endcontent.endcontentModel.result?[index].id);
                        },
                        child: MyText(
                            title: "Winner Details",
                            size: 16,
                            fontWeight: FontWeight.w600,
                            colors: appColor),
                      ),
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

  void winnerList(var contestId) {
    final winnerdata = Provider.of<ApiProvider>(context, listen: false);
    winnerdata.getContestWinnerList(contestId.toString());

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            decoration: const BoxDecoration(
              color: white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 40,
                    color: primary,
                    child: Row(
                      children: [
                        Expanded(
                            child: MyText(
                          title: "Rank",
                          textalign: TextAlign.center,
                          size: 16,
                          fontWeight: FontWeight.w600,
                          maxline: 1,
                          colors: white,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Expanded(
                            child: MyText(
                          title: "Name",
                          textalign: TextAlign.center,
                          size: 16,
                          fontWeight: FontWeight.w600,
                          maxline: 1,
                          colors: white,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Expanded(
                            child: MyText(
                          title: "Winnings",
                          textalign: TextAlign.center,
                          size: 16,
                          colors: white,
                          fontWeight: FontWeight.w600,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                  ListView.separated(
                    itemCount: winnerdata.winnerModel.result?.length ?? 0,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            Expanded(
                                child: MyText(
                              title:
                                  (winnerdata.winnerModel.result?[index].rank ??
                                          0)
                                      .toString(),
                              textalign: TextAlign.center,
                              size: 16,
                              fontWeight: FontWeight.w600,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            Expanded(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyImage(
                                    width: 20,
                                    height: 20,
                                    imagePath: "assets/images/ic_icons.png"),
                                MyText(
                                  title: (winnerdata.winnerModel.result?[index]
                                              .fullname ??
                                          "")
                                      .toString(),
                                  textalign: TextAlign.center,
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )),
                            Expanded(
                                child: MyText(
                              title: (winnerdata
                                          .winnerModel.result?[index].price ??
                                      0)
                                  .toString(),
                              textalign: TextAlign.center,
                              size: 16,
                              fontWeight: FontWeight.w600,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: textColorGrey,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
