import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sanad/model/questionmodel.dart';
import 'package:sanad/pages/quiz/levelresult.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/provider/commanprovider.dart';
import 'package:sanad/theme/color.dart';
import 'package:sanad/utils/adhelper.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/utils/utility.dart';
import 'package:sanad/widget/myimage.dart';
import 'package:sanad/widget/mynetimage.dart';
import 'package:sanad/widget/mytext.dart';

// Type 1 = 4 option & 2 = true/false
// question_level_master_id 0=easy - medium etc
// Right - wrong question manage manually
//
class Questions extends StatefulWidget {
  String? catId, levelId, levelname;
  Questions(
      {Key? key,
      required this.catId,
      required this.levelId,
      required this.levelname})
      : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final CustomTimerController _controller = CustomTimerController();
  SharePref sharePref = SharePref();
  String? userId;

  final playerC = AudioPlayer();
  final playerW = AudioPlayer();

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

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";

    AdHelper.createInterstitialAd();
    AdHelper.createRewardedAd();
  }

  playSound(int pos) async {
    await playerC.setUrl('asset:assets/audio/correct.mp3');
    await playerW.setUrl('asset:assets/audio/wrong.mp3');
    if (playerC.playing) {
      await playerC.stop();
    }
    if (playerW.playing) {
      await playerW.stop();
    }
    if (pos == 1) {
      await playerC.play();
    } else {
      await playerW.play();
    }
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
      return 'A. ${questionList?[qindex].optionA ?? ""}';
    } else if (index == 1) {
      return 'B. ${questionList?[qindex].optionB ?? ""}';
    } else if (index == 2) {
      return 'C. ${questionList?[qindex].optionC ?? ""}';
    } else {
      return 'D. ${questionList?[qindex].optionD ?? ""}';
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
                title: widget.levelname.toString(),
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
                                  '${((questiondata.selectQuestion ?? 0) + 1)} / ${questiondata.questionModel.result?.length ?? 0}',
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
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
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
                        if (questionList?.length.toInt() == 0) {
                          Utility.toastMessage("There are no any Questions");
                          Timer(const Duration(seconds: 3), () {
                            Navigator.of(context).pop();
                          });
                        }
                        // _controller.start();
                      }
                      log("===> Selection ${questiondata.selectQuestion}");
                      return questiondata.loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : questionList?.length.toInt() != 0
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
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
                                                        color: primary,
                                                        width: 4),
                                                    color: white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                100))),
                                                child: CircularPercentIndicator(
                                                  radius: 30.0,
                                                  lineWidth: 4.0,
                                                  animation: false,
                                                  percent: percent / 100,
                                                  center: Text(
                                                    percent.toInt().toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  backgroundColor: Colors.grey,
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor:
                                                      Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                            // Question Count
                                            Positioned(
                                              top: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 30, right: 30),
                                                child: Consumer<CommanProvider>(
                                                  builder: (context,
                                                      commandProvider, child) {
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
                                                              percent:
                                                                  (commandProvider
                                                                          .correctPercent /
                                                                      100),
                                                              barRadius:
                                                                  const Radius
                                                                      .circular(20),
                                                              progressColor: Colors
                                                                  .greenAccent,
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
                                                              percent:
                                                                  (commandProvider
                                                                          .incorrectPercent /
                                                                      100),
                                                              barRadius:
                                                                  const Radius
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
                                      MyText(
                                        title: "Bollywood",
                                        fontWeight: FontWeight.w500,
                                        size: 16,
                                        colors: textColorGrey,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      (questionList?[questiondata
                                                              .selectQuestion ??
                                                          0]
                                                      .image
                                                      ?.length ??
                                                  0) >
                                              0
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  MyNetImage(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.25,
                                                      fit: BoxFit.fill,
                                                      imagePath: questionList?[
                                                                  questiondata
                                                                          .selectQuestion ??
                                                                      0]
                                                              .image
                                                              .toString() ??
                                                          ""),
                                                  const SizedBox(height: 5),
                                                  AutoSizeText(
                                                    questionList?[questiondata
                                                                    .selectQuestion ??
                                                                0]
                                                            .question
                                                            .toString() ??
                                                        "",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 16,
                                                        color: textColorGrey,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    minFontSize: 12,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ))
                                          : SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                              child: Center(
                                                child: AutoSizeText(
                                                  questionList?[questiondata
                                                                  .selectQuestion ??
                                                              0]
                                                          .question
                                                          .toString() ??
                                                      "",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 22,
                                                      color: textColorGrey,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  minFontSize: 12,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 6,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                      const SizedBox(height: 23),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: (questionList?[
                                                                  questiondata
                                                                          .selectQuestion ??
                                                                      0]
                                                              .image
                                                              ?.length ??
                                                          0) >
                                                      0
                                                  ? 2
                                                  : 1,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: (questionList?[
                                                                  questiondata
                                                                          .selectQuestion ??
                                                                      0]
                                                              .image
                                                              ?.length ??
                                                          0) >
                                                      0
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          7)
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          14),
                                            ),
                                            itemCount: 4,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return Consumer<CommanProvider>(
                                                builder:
                                                    (context, answer, child) {
                                                  debugPrint(
                                                      'select Answer===>${answer.selectAnswer}');
                                                  debugPrint(
                                                      'correct Answer===>${answer.correctAns}');
                                                  debugPrint('index===>$index');
                                                  return InkWell(
                                                    onTap: () {
                                                      Provider.of<CommanProvider>(
                                                              context,
                                                              listen: false)
                                                          .answerclick(index);
                                                    },
                                                    child: answer
                                                                .selectAnswer ==
                                                            index
                                                        ? answer.correctAns ==
                                                                (index + 1)
                                                            ? Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color:
                                                                            green,
                                                                        width:
                                                                            0.4),
                                                                    color:
                                                                        green,
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            25))),
                                                                child:
                                                                    AutoSizeText(
                                                                  getAnswer(
                                                                      (questiondata
                                                                              .selectQuestion ??
                                                                          0),
                                                                      index),
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          18,
                                                                      color:
                                                                          white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  minFontSize:
                                                                      10,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            : Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color:
                                                                            inActiveColor,
                                                                        width:
                                                                            0.4),
                                                                    color:
                                                                        inActiveColor,
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            25))),
                                                                child:
                                                                    AutoSizeText(
                                                                  getAnswer(
                                                                      (questiondata
                                                                              .selectQuestion ??
                                                                          0),
                                                                      index),
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          18,
                                                                      color:
                                                                          white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  minFontSize:
                                                                      10,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                        : answer.correctAns ==
                                                                (index + 1)
                                                            ? Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color:
                                                                            green,
                                                                        width:
                                                                            0.4),
                                                                    color:
                                                                        green,
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            25))),
                                                                child:
                                                                    AutoSizeText(
                                                                  getAnswer(
                                                                      (questiondata
                                                                              .selectQuestion ??
                                                                          0),
                                                                      index),
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          18,
                                                                      color:
                                                                          white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  minFontSize:
                                                                      10,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            : Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color:
                                                                            textColorGrey,
                                                                        width:
                                                                            0.4),
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            25))),
                                                                child:
                                                                    AutoSizeText(
                                                                  getAnswer(
                                                                      (questiondata
                                                                              .selectQuestion ??
                                                                          0),
                                                                      index),
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                  minFontSize:
                                                                      10,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                  );
                                                },
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
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
                                                                      listen:
                                                                          false)
                                                                  .selectAnswer ??
                                                              0;

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
                                                                    0,
                                                                int.parse(questiondata
                                                                        .questionModel
                                                                        .result?[
                                                                            questiondata.selectQuestion ??
                                                                                0]
                                                                        .answer ??
                                                                    ""));

                                                        Provider.of<CommanProvider>(
                                                                context,
                                                                listen: false)
                                                            .corAns(int.parse(questiondata
                                                                    .questionModel
                                                                    .result?[
                                                                        questiondata.selectQuestion ??
                                                                            0]
                                                                    .answer ??
                                                                ""));
                                                        playSound(1);
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
                                                                    0,
                                                                int.parse(questiondata
                                                                        .questionModel
                                                                        .result?[
                                                                            questiondata.selectQuestion ??
                                                                                0]
                                                                        .answer ??
                                                                    ""));
                                                        Provider.of<CommanProvider>(
                                                                context,
                                                                listen: false)
                                                            .corAns(int.parse(questiondata
                                                                    .questionModel
                                                                    .result?[
                                                                        questiondata.selectQuestion ??
                                                                            0]
                                                                    .answer ??
                                                                ""));

                                                        playSound(0);
                                                      }
                                                      if ((questiondata
                                                                  .selectQuestion ??
                                                              0) <
                                                          (questionList
                                                                      ?.length ??
                                                                  0) -
                                                              1) {
                                                        Timer(
                                                            const Duration(
                                                                seconds: 5),
                                                            () {
                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .answerclick(-1);
                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .corAns(-1);
                                                          Provider.of<ApiProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .changeQuestion(
                                                                  (questiondata
                                                                              .selectQuestion ??
                                                                          0) +
                                                                      1);
                                                        });
                                                      } else {
                                                        Timer(
                                                            const Duration(
                                                                seconds: 5),
                                                            () {
                                                          Provider.of<ApiProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .changeQuestion(
                                                                  0);

                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .correctAnswer(
                                                                  0,
                                                                  questiondata
                                                                          .questionModel
                                                                          .result
                                                                          ?.length ??
                                                                      0,
                                                                  int.parse(questiondata
                                                                          .questionModel
                                                                          .result?[questiondata.selectQuestion ??
                                                                              0]
                                                                          .answer ??
                                                                      ""));

                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .inCorrectAnswer(
                                                                  0,
                                                                  questiondata
                                                                          .questionModel
                                                                          .result
                                                                          ?.length ??
                                                                      0,
                                                                  int.parse(questiondata
                                                                          .questionModel
                                                                          .result?[questiondata.selectQuestion ??
                                                                              0]
                                                                          .answer ??
                                                                      ""));

                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .answerclick(-1);

                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .corAns(-1);

                                                          saveQuestionReport();
                                                        });
                                                      }
                                                    },
                                                    child: MyText(
                                                      title: "Answer It",
                                                      colors: white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      size: 16,
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(primary),
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
                                                      int selectAnswer =
                                                          Provider.of<CommanProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .selectAnswer ??
                                                              0;

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
                                                                    0,
                                                                int.parse(questiondata
                                                                        .questionModel
                                                                        .result?[
                                                                            questiondata.selectQuestion ??
                                                                                0]
                                                                        .answer ??
                                                                    ""));
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
                                                                    0,
                                                                int.parse(questiondata
                                                                        .questionModel
                                                                        .result?[
                                                                            questiondata.selectQuestion ??
                                                                                0]
                                                                        .answer ??
                                                                    ""));
                                                      }
                                                      if ((questiondata
                                                                  .selectQuestion ??
                                                              0) <
                                                          (questionList
                                                                      ?.length ??
                                                                  0) -
                                                              1) {
                                                        Provider.of<CommanProvider>(
                                                                context,
                                                                listen: false)
                                                            .answerclick(-1);
                                                        Provider.of<ApiProvider>(
                                                                context,
                                                                listen: false)
                                                            .changeQuestion(
                                                                (questiondata
                                                                            .selectQuestion ??
                                                                        0) +
                                                                    1);
                                                      } else {
                                                        Timer(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                          // Provider.of<ApiProvider>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .changeQuestion(0);

                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .correctAnswer(
                                                                  0,
                                                                  questiondata
                                                                          .questionModel
                                                                          .result
                                                                          ?.length ??
                                                                      0,
                                                                  int.parse(questiondata
                                                                          .questionModel
                                                                          .result?[questiondata.selectQuestion ??
                                                                              0]
                                                                          .answer ??
                                                                      ""));

                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .inCorrectAnswer(
                                                                  0,
                                                                  questiondata
                                                                          .questionModel
                                                                          .result
                                                                          ?.length ??
                                                                      0,
                                                                  int.parse(questiondata
                                                                          .questionModel
                                                                          .result?[questiondata.selectQuestion ??
                                                                              0]
                                                                          .answer ??
                                                                      ""));

                                                          Provider.of<CommanProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .answerclick(-1);

                                                          Provider.of<ApiProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .selectQuestion = 0;
                                                          saveQuestionReport();
                                                        });
                                                      }
                                                    },
                                                    child: MyText(
                                                      title: "Next",
                                                      colors: black,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                )
                              : Container();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                child: AdWidget(
                    ad: AdHelper.createBannerAd()..load(), key: UniqueKey()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveQuestionReport() async {
    int correctAns =
        Provider.of<CommanProvider>(context, listen: false).correctanswer;
    debugPrint(correctAns.toString());

    final provider = Provider.of<ApiProvider>(context, listen: false);
    await provider.getSaveQuestionReport(
        context,
        widget.levelId.toString(),
        (questionList?.length ?? 0).toString(),
        (questionList?.length ?? 0).toString(),
        correctAns.toString(),
        userId.toString(),
        widget.catId.toString());
    debugPrint('===>get responce${provider.successModel.status}');
    if (provider.loading) {
      const CircularProgressIndicator();
    } else {
      if (provider.successModel.status == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LevelResult(
                  levelId: widget.levelId,
                )));
      }
    }
  }
}
