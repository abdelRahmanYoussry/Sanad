import 'dart:async';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/model/questionmodel.dart';
import 'package:quizapp/pages/levelresult.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/provider/commanprovider.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/widget/myimage.dart';
import 'package:quizapp/widget/mytext.dart';

// Type 1 = 4 option & 2 = true/false
// question_level_master_id 0=easy - medium etc
// Right - wrong question manage manually
//
class Questions extends StatefulWidget {
  String? catId, levelId;
  Questions({Key? key, required this.catId, required this.levelId})
      : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final CustomTimerController _controller = CustomTimerController();

  double percent = 0.0;
  Timer? timer;

  int answercnt = 1;
  int selectAnswer = -1;

  List<Result>? questionList = [];

  @override
  void initState() {
    super.initState();
    final questiondata = Provider.of<ApiProvider>(context, listen: false);
    questiondata.getQuestionByLevel(
        context, widget.catId, widget.levelId.toString());
    // counter();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  void counter() {
    // timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
    //   setState(() {
    //     percent += 1;
    //     if (percent >= 100) {
    //       timer?.cancel();
    //       percent = 0;
    //       print(percent);
    //     }
    //   });
    // });
  }

  getAnswer(int qindex, index) {
    if (index == 0) {
      return questionList?[qindex].optionA ?? "";
    } else if (index == 1) {
      return questionList?[qindex].optionB ?? "";
    } else if (index == 2) {
      return questionList?[qindex].optionC ?? "";
    } else {
      return questionList?[qindex].optionD ?? "";
    }
  }

  double cntvalue = 0;

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
                      child: Consumer<ApiProvider>(
                        builder: (context, questiondata, child) {
                          return MyText(
                              title:
                                  '${questiondata.selectQuestion}/ ${questiondata.questionModel.result?.length ?? 0}',
                              size: 18,
                              fontWeight: FontWeight.w400,
                              colors: white);
                        },
                      ),
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
                child: Consumer<ApiProvider>(
                  builder: (context, questiondata, child) {
                    if (!questiondata.loading) {
                      debugPrint('questiondata===>$questiondata');
                      questionList =
                          questiondata.questionModel.result as List<Result>;
                      debugPrint(questionList?.length.toString());
                      // _controller.start();
                    }
                    return questiondata.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
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
                                              border: Border.all(
                                                  color: primary, width: 4),
                                              color: white,
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      // Question Count
                                      Positioned(
                                        top: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Consumer<CommanProvider>(
                                            builder: (context, commandProvider,
                                                child) {
                                              return Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      MyText(
                                                          title: commandProvider
                                                              .correctanswer
                                                              .toString()),
                                                      LinearPercentIndicator(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        animation: false,
                                                        lineHeight: 3.0,
                                                        percent: commandProvider
                                                            .correctPercent,
                                                        barRadius: const Radius
                                                            .circular(20),
                                                        progressColor:
                                                            Colors.greenAccent,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      LinearPercentIndicator(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        animation: false,
                                                        lineHeight: 3.0,
                                                        percent: commandProvider
                                                            .incorrectPercent,
                                                        barRadius: const Radius
                                                            .circular(20),
                                                        progressColor:
                                                            Colors.red,
                                                      ),
                                                      MyText(
                                                          title: commandProvider
                                                              .inCorrectanswer
                                                              .toString()),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
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
                                  title: questionList?[
                                              questiondata.selectQuestion ?? 0]
                                          .question
                                          .toString() ??
                                      "",
                                  fontWeight: FontWeight.w500,
                                  size: 18,
                                  maxline: 4,
                                  textalign: TextAlign.center,
                                  colors: textColorGrey,
                                ),
                                const SizedBox(height: 25),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: answercnt,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: answercnt == 1
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    12)
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    7),
                                      ),
                                      itemCount: 4,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return Consumer<CommanProvider>(
                                          builder: (context, answer, child) {
                                            debugPrint(
                                                'select===>${answer.selectAnswer}');
                                            return InkWell(
                                              onTap: () {
                                                Provider.of<CommanProvider>(
                                                        context,
                                                        listen: false)
                                                    .answerclick(index);
                                              },
                                              child: answer.selectAnswer ==
                                                      index
                                                  ? Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25,
                                                              right: 10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: green,
                                                              width: 0.4),
                                                          color: green,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                      child: MyText(
                                                        title: getAnswer(
                                                            (questiondata
                                                                    .selectQuestion ??
                                                                0),
                                                            index),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxline: 2,
                                                        size: 18,
                                                        colors: white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textalign:
                                                            TextAlign.left,
                                                      ),
                                                    )
                                                  : Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 50,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25,
                                                              right: 10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  textColorGrey,
                                                              width: 0.4),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                      child: MyText(
                                                        title: getAnswer(
                                                            (questiondata
                                                                    .selectQuestion ??
                                                                0),
                                                            index),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxline: 2,
                                                        size: 16,
                                                        textalign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                            );
                                          },
                                        );
                                      }),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 50,
                                          child: TextButton(
                                              onPressed: () {
                                                int selectAnswer =
                                                    Provider.of<CommanProvider>(
                                                                context,
                                                                listen: false)
                                                            .selectAnswer ??
                                                        0;
                                                print((selectAnswer + 1)
                                                    .toString());
                                                print(
                                                    '${questiondata.questionModel.result?[questiondata.selectQuestion ?? 0].answer}');
                                                if ((selectAnswer + 1)
                                                        .toString() ==
                                                    questiondata
                                                        .questionModel
                                                        .result?[questiondata
                                                                .selectQuestion ??
                                                            0]
                                                        .answer) {
                                                  print('Correct');
                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .correctAnswer(
                                                          1,
                                                          questiondata
                                                                  .questionModel
                                                                  .result
                                                                  ?.length ??
                                                              0);
                                                } else {
                                                  print('InCorrect');
                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .inCorrectAnswer(
                                                          1,
                                                          questiondata
                                                                  .questionModel
                                                                  .result
                                                                  ?.length ??
                                                              0);
                                                }
                                                if ((questiondata
                                                            .selectQuestion ??
                                                        0) <
                                                    (questionList?.length ??
                                                            0) -
                                                        1) {
                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .answerclick(-1);
                                                  Provider.of<ApiProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeQuestion((questiondata
                                                                  .selectQuestion ??
                                                              0) +
                                                          1);
                                                } else {
                                                  Provider.of<ApiProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeQuestion(0);

                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .correctAnswer(
                                                          0,
                                                          questiondata
                                                                  .questionModel
                                                                  .result
                                                                  ?.length ??
                                                              0);

                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .inCorrectAnswer(
                                                          0,
                                                          questiondata
                                                                  .questionModel
                                                                  .result
                                                                  ?.length ??
                                                              0);

                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .answerclick(-1);
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const LevelResult()));
                                                }
                                              },
                                              child: MyText(
                                                title: "Answer It",
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
                                                              color:
                                                                  primary))))),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 50,
                                          child: TextButton(
                                              onPressed: () {
                                                if ((questiondata
                                                            .selectQuestion ??
                                                        0) <
                                                    (questionList?.length ??
                                                            0) -
                                                        1) {
                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .answerclick(-1);
                                                  Provider.of<ApiProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeQuestion((questiondata
                                                                  .selectQuestion ??
                                                              0) +
                                                          1);
                                                } else {
                                                  Provider.of<ApiProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeQuestion(0);

                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .correctAnswer(
                                                          0,
                                                          questiondata
                                                                  .questionModel
                                                                  .result
                                                                  ?.length ??
                                                              0);

                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .inCorrectAnswer(
                                                          0,
                                                          questiondata
                                                                  .questionModel
                                                                  .result
                                                                  ?.length ??
                                                              0);

                                                  Provider.of<CommanProvider>(
                                                          context,
                                                          listen: false)
                                                      .answerclick(-1);
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const LevelResult()));
                                                }
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
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          side: const BorderSide(
                                                              color:
                                                                  textColorGrey))))),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                  },
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
