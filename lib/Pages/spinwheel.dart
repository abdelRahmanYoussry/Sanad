import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/model/earnpointsmodel.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/utils/adhelper.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/utils/utility.dart';
import 'package:quizapp/widget/mytext.dart';
import '../widget/myappbar.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  _SpinWheelState createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final StreamController<int> controller = StreamController<int>();
  var list = [1, 2, 3, 4, 5, 6, 7, 8];
  final _random = new Random();
  late int index;
  String? userId;
  SharePref sharePref = SharePref();
  var spinlist = [100, 200, 300, 400, 500, 600, 700, 800];

  @override
  void initState() {
    getLogin();
    super.initState();
  }

  getLogin() async {
    userId = await sharePref.read('userId') ?? "";
    debugPrint('userID===>${userId.toString()}');

    final earnProvider = Provider.of<ApiProvider>(context, listen: false);
    earnProvider.getEarnPointList();

    AdHelper.createInterstitialAd();
    AdHelper.createRewardedAd();
  }

  getRewardPoint() async {
    final earnProvider = Provider.of<ApiProvider>(context, listen: false);
    earnProvider.getaddRewardPoints(userId, spinlist[index], "1");
    if (!earnProvider.loading) {
      Utility.toastMessage(earnProvider.successModel.message.toString());
      AdHelper.showRewardedAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    index = list[_random.nextInt(list.length)];
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: getAppbar(),
        backgroundColor: Colors.transparent,
        body: spinwheel(),
      ),
    );
  }

  getAppbar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: MyAppbar(
        title: "Spin & Wheel",
      ),
    );
  }

  spinwheel() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: Container(
            color: white,
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: MyText(
                    title: "Today's Free Spin",
                    fontWeight: FontWeight.bold,
                    colors: black,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: MyText(
                    title: "Win upto 2700+ points by Online QuizApp",
                    fontWeight: FontWeight.w500,
                    colors: textColorGrey,
                    size: 14,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FortuneWheel(
                        selected: Stream.value(index),
                        indicators: const <FortuneIndicator>[
                          FortuneIndicator(
                            alignment: Alignment.topCenter,
                            child: TriangleIndicator(
                              color: primary,
                            ),
                          ),
                        ],
                        physics: CircularPanPhysics(
                          duration: const Duration(seconds: 1),
                          curve: Curves.decelerate,
                        ),
                        onAnimationEnd: () {
                          debugPrint("end=====================");
                          getRewardPoint();
                        },
                        items: const [
                          FortuneItem(
                            child: Text(
                              '200',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelOne,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                          FortuneItem(
                            child: Text(
                              '100',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelTwo,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                          FortuneItem(
                            child: Text(
                              '300',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelThree,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                          FortuneItem(
                            child: Text(
                              '400',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelFour,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                          FortuneItem(
                            child: Text(
                              '500',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelTwo,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                          FortuneItem(
                            child: Text(
                              '600',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelOne,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                          FortuneItem(
                            child: Text(
                              '700',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelThree,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                          FortuneItem(
                            child: Text(
                              '800',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            style: FortuneItemStyle(
                              color: wheelFour,
                              borderColor: black,
                              borderWidth: 5,
                            ),
                          ),
                        ],
                      )),
                ),
                // const SizedBox(height: 20),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.06,
                //   width: MediaQuery.of(context).size.width * 0.4,
                //   child: TextButton(
                //       onPressed: () {
                //         setState(() {});
                //       },
                //       child: MyText(
                //         title: "Spin",
                //         colors: white,
                //         fontWeight: FontWeight.w500,
                //         size: 18,
                //       ),
                //       style: ButtonStyle(
                //           backgroundColor: MaterialStateProperty.all(primary),
                //           shape:
                //               MaterialStateProperty.all<RoundedRectangleBorder>(
                //                   RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(25.0),
                //                       side:
                //                           const BorderSide(color: primary))))),
                // )
              ],
            ),
          )),
    );
  }

  FortuneItem wheel() {
    return FortuneItem(
      child: Text(
        '200',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      style: FortuneItemStyle(
        color: wheelOne,
        borderColor: black,
        borderWidth: 5,
      ),
    );
  }
}
