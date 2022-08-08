import 'dart:async';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizapp/model/loginmodel.dart';
import 'package:quizapp/pages/levelresult.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/widget/myimage.dart';
import 'package:quizapp/widget/mytext.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final CustomTimerController _controller = CustomTimerController();

  double percent = 0.0;
  Timer? timer;

  int quecnt = 0;
  int answercnt = 1;
  int selectAnswer = -1;

  List question = [
    "Which was first Indian movie released commercially in Italy?",
    "Which was first Indian movie released commercially in India?",
    "Which was first Indian movie released commercially in USA?",
    "Which was first Indian movie released commercially in Africa?",
    "Which was first Indian movie released commercially in Australia?",
    "Which was first Indian movie released commercially in London?",
    "Which was first Indian movie released commercially in UK?",
    "Which was first Indian movie released commercially in China?",
    "Which was first Indian movie released commercially in Singapore?",
    "Which was first Indian movie released commercially in India?"
  ];
  List answer = [
    "Mother India,Jocker,RRR,Pushpa",
    "RRR,Bahubali,Pushpa,Jocker",
    "Bahubali,RRR,Jocker,Pushpa",
    "RRR,Bahubali,Pushpa,Jocker",
    "Pushpa,RRR,Jocker,Bahubali",
    "RRR,Bahubali,Pushpa,Jocker",
    "Jocker,RRR,Bahubali,Pushpa",
    "Pushpa,Bahubali,Jocker,RRR",
    "RRR,Bahubali,Pushpa,Jocker",
    "Bahubali,RRR,Jocker,Pushpa"
  ];
  @override
  void initState() {
    super.initState();
    counter();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void counter() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      setState(() {
        percent += 1;
        if (percent >= 100) {
          timer?.cancel();
          percent = 0;
          print(percent);
        }
      });
    });
  }

  double cntvalue = 0;

  @override
  Widget build(BuildContext context) {
    _controller.start();
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            title: Center(
              child: MyText(
                title: "Level 1",
                size: 18,
                fontWeight: FontWeight.w400,
                colors: white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    child: Center(
                      child: MyText(
                          title: "6 / 10",
                          size: 18,
                          fontWeight: FontWeight.w400,
                          colors: white),
                    ),
                  )),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_bg_white.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              child: Container(
                                height: 70,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: primary, width: 4),
                                    color: white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 4.0,
                                  animation: false,
                                  percent: percent / 100,
                                  center: Text(
                                    percent.toInt().toString(),
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  backgroundColor: Colors.grey,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.redAccent,
                                ),
                              ),
                            ),
                            // Question Count
                            Positioned(
                              top: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        MyText(title: "3"),
                                        LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          animation: false,
                                          lineHeight: 3.0,
                                          percent: 0.5,
                                          barRadius: const Radius.circular(20),
                                          progressColor: Colors.greenAccent,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          animation: false,
                                          lineHeight: 3.0,
                                          percent: 0.5,
                                          barRadius: const Radius.circular(20),
                                          progressColor: Colors.red,
                                        ),
                                        MyText(title: "4"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      MyText(
                        title: "Bollywood",
                        fontWeight: FontWeight.w500,
                        size: 16,
                        colors: textColorGrey,
                      ),
                      const SizedBox(height: 15),
                      MyText(
                        title: question[quecnt].toString(),
                        fontWeight: FontWeight.w500,
                        size: 18,
                        maxline: 4,
                        textalign: TextAlign.center,
                        colors: textColorGrey,
                      ),
                      const SizedBox(height: 25),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: answercnt,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: answercnt == 1
                                  ? MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 12)
                                  : MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 7),
                            ),
                            itemCount: 4,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectAnswer = index;
                                  });
                                },
                                child: selectAnswer == index
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: green, width: 0.4),
                                            color: green,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(25))),
                                        child: MyText(
                                          title: "A. Ankhen",
                                          overflow: TextOverflow.ellipsis,
                                          maxline: 2,
                                          size: 18,
                                          colors: white,
                                          fontWeight: FontWeight.w500,
                                          textalign: TextAlign.left,
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.centerLeft,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: textColorGrey,
                                                width: 0.4),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(25))),
                                        child: MyText(
                                          title: "A. Ankhen",
                                          overflow: TextOverflow.ellipsis,
                                          maxline: 2,
                                          size: 16,
                                          textalign: TextAlign.left,
                                        ),
                                      ),
                              );
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                    onPressed: () {
                                      if (quecnt < question.length - 1) {
                                        quecnt++;
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const LevelResult()));
                                      }
                                      setState(() {});
                                    },
                                    child: MyText(
                                      title: "Answer It",
                                      colors: white,
                                      fontWeight: FontWeight.w500,
                                      size: 16,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(primary),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                side: const BorderSide(
                                                    color: primary))))),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 50,
                                child: TextButton(
                                    onPressed: () {
                                      if (quecnt < question.length - 1) {
                                        quecnt++;
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const LevelResult()));
                                      }
                                      setState(() {});
                                    },
                                    child: MyText(
                                      title: "Next",
                                      colors: black,
                                      fontWeight: FontWeight.w500,
                                      size: 16,
                                    ),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                side: const BorderSide(
                                                    color: textColorGrey))))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MyImage(
                height: 80,
                width: 80,
                imagePath: "assets/images/ic_close.png",
              )
            ],
          ),
        ),
      ),
    );
  }
}
