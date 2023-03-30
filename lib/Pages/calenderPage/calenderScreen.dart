import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanad/pages/contest/contest.dart';
import 'package:sanad/pages/home.dart';
import 'package:sanad/pages/target/targetScreen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Theme/color.dart';
import '../../provider/apiprovider.dart';
import '../../utils/sharepref.dart';
import '../../utils/utility.dart';
import '../../widget/mynetimage.dart';
import '../contest/contestquestions.dart';

class CalenderScreen extends StatefulWidget {
  CalenderScreen(
      {Key? key, required this.questionId, required this.contestName})
      : super(key: key);
  String questionId, contestName;

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  String? userId;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Duration _differenceDay = const Duration(days: 0);
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  int index2 = 0;
  @override
  initState() {
    getUserId();
    _selectedDay = DateTime.now();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  getUserId() async {
    SharePref sharePref = SharePref();
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID _Contest ===>${userId.toString()}');
    final upcomingdata = Provider.of<ApiProvider>(context, listen: false);
    // upcomingdata.getQuestionByContestTest(context, widget.questionId);
    upcomingdata.getQuestionByContest(context, widget.questionId);
    upcomingdata.getLiveContent(context, 'live', userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, livecontent, live) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Challenge Calender'),
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Utility.navigateAndFinish(context, const Contest());
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: [
              TableCalendar(
                calendarFormat: CalendarFormat.month,
                rowHeight: 35,
                // onRangeSelected: (day1, day2, day3) {
                //   print(day1.toString());
                //   print(day2.toString());
                //   print(day3.toString());
                // },

                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                    rangeHighlightColor: cyan.withOpacity(0.3),
                    rangeStartDecoration: const BoxDecoration(
                        color: cyan, shape: BoxShape.circle),
                    rangeEndDecoration: const BoxDecoration(
                        color: cyan, shape: BoxShape.circle),
                    selectedDecoration: const BoxDecoration(
                      color: appColor,
                      shape: BoxShape.circle,
                    )),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(
                    days: livecontent.contestQuestionModel.result!.length - 1)),
                focusedDay: _focusedDay,
                rangeSelectionMode: _rangeSelectionMode,
                onDisabledDayTapped: (day) {
                  Utility.toastMessage('Please Select Day from Range');
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;

                      _differenceDay = _selectedDay!.difference(DateTime.now());
                      if (index2 <=
                          livecontent.contestQuestionModel.result!.length) {
                        int daysBetween(DateTime from, DateTime to) {
                          from = DateTime(from.year, from.month, from.day);
                          to = DateTime(to.year, to.month, to.day);
                          return (to.difference(from).inHours / 24).round();
                        }

                        index2 = daysBetween(DateTime.now(), _selectedDay!);

                        // index2 = _differenceDay.inDays;
                      }
                      if (index2 ==
                          livecontent.contestQuestionModel.result!.length) {
                        index2 = 0;
                      }

                      debugPrint(_differenceDay.inDays.toString() +
                          'this is _differenceDay');
                    });
                  }
                },
                rangeStartDay: DateTime.now(),
                rangeEndDay: DateTime.now().add(Duration(
                    days: livecontent.contestQuestionModel.result!.length - 1)),
                // rangeEndDay: DateTime.now().add(Duration(days: 3)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Question'),
              Text(
                livecontent.contestQuestionModel.result!.isEmpty
                    ? 'No question'
                    : livecontent
                        .contestQuestionModel.result![index2].question!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              if (livecontent.contestQuestionModel.result!.isNotEmpty)
                MyNetImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    fit: BoxFit.fill,
                    imagePath: livecontent
                                .contestQuestionModel.result![index2].image ==
                            ""
                        ? 'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg?w=1060'
                        : livecontent
                            .contestQuestionModel.result![index2].image!),
              const Spacer(
                flex: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Utility.navigateAndFinish(context, Home());
                      // Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: baseColor, fontSize: 20),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(cyan),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(28.0))))),
                    onPressed: () async {
                      DateTime now = DateTime.now();
                      //
                      // debugPrint(now.toLocal().toString().split(' ')[0] +
                      //     '  this is now');
                      // debugPrint(_selectedDay.toString().split(' ')[0] +
                      //     '  this is selected');
                      // if (livecontent.contestQuestionModel.result![index2]
                      //         .questionType ==
                      //     3) {
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => TargetScreen(
                      //                 result: livecontent
                      //                     .contestQuestionModel.result![index2],
                      //                 contestName: widget.contestName,
                      //                 questionId: widget.questionId,
                      //               )));
                      // } else if (livecontent.contestQuestionModel
                      //         .result![index2].questionType ==
                      //     1) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ContestQuestions(
                      //                 contestId: widget.questionId.toString(),
                      //                 contestName: widget.contestName,
                      //               )));
                      // } else {
                      //   Utility.toastMessage(' Coming Soon Waiting For Api \n'
                      //       'the Question type is:  ${livecontent.contestQuestionModel.result![index2].questionType}  ');
                      // }
                      if (now.toString().split(' ')[0] ==
                          _selectedDay.toString().split(' ')[0]) {
                        if (livecontent.contestQuestionModel.result![index2]
                                .questionType ==
                            3) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TargetScreen(
                                        result: livecontent.contestQuestionModel
                                            .result![index2],
                                        contestName: widget.contestName,
                                        questionId: widget.questionId,
                                      )));
                        } else if (livecontent.contestQuestionModel
                                .result![index2].questionType ==
                            1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContestQuestions(
                                        contestId: widget.questionId.toString(),
                                        contestName: widget.contestName,
                                      )));
                        } else {
                          Utility.toastMessage(' Coming Soon Waiting For Api \n'
                              'the Question type is:  ${livecontent.contestQuestionModel.result![index2].questionType}  ');
                        }
                      } else {
                        Utility.toastMessage(
                            'No Matching With Selected Day \n Please Select '
                            'another question');
                      }
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
          // ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: 1,
          //     itemBuilder: (context, index) {
          //       print(index);
          //       return SizedBox(
          //         height: MediaQuery.of(context).size.height,
          //         child: Column(
          //           children: [
          //             TableCalendar(
          //               calendarFormat: CalendarFormat.month,
          //               rowHeight: 35,
          //               headerStyle: const HeaderStyle(
          //                 formatButtonVisible: false,
          //                 titleCentered: true,
          //               ),
          //               calendarStyle: CalendarStyle(
          //                   rangeHighlightColor: cyan.withOpacity(0.3),
          //                   rangeStartDecoration: BoxDecoration(
          //                       color: cyan, shape: BoxShape.circle),
          //                   rangeEndDecoration: const BoxDecoration(
          //                       color: cyan, shape: BoxShape.circle),
          //                   selectedDecoration: const BoxDecoration(
          //                     color: appColor,
          //                     shape: BoxShape.circle,
          //                   )),
          //               selectedDayPredicate: (day) =>
          //                   isSameDay(_selectedDay, day),
          //               firstDay: DateTime(2023, 1, 1),
          //               lastDay: DateTime(2200, 1, 1),
          //               focusedDay: _focusedDay,
          //               rangeSelectionMode: _rangeSelectionMode,
          //               onDaySelected: (selectedDay, focusedDay) {
          //                 if (!isSameDay(_selectedDay, selectedDay)) {
          //                   setState(() {
          //                     _selectedDay = selectedDay;
          //                     _focusedDay = focusedDay;
          //                     _rangeSelectionMode =
          //                         RangeSelectionMode.toggledOff;
          //                     if (index <=
          //                         livecontent
          //                             .contestQuestionModel.result!.length) {
          //                       index = index + 1;
          //                       // debugPrint(livecontent
          //                       //     .contestQuestionModelNew.result!.length
          //                       //     .toString());
          //                       // debugPrint(index.toString() + 'index');
          //                     }
          //                     if (index ==
          //                         livecontent
          //                             .contestQuestionModel.result!.length) {
          //                       index = 0;
          //                     }
          //                     _differenceDay =
          //                         _selectedDay!.difference(DateTime.now());
          //                     debugPrint(_focusedDay.day.toString() +
          //                         'this is focused');
          //                     debugPrint(_selectedDay!.day.toString() +
          //                         'this is _selectedDay');
          //                   });
          //                 }
          //               },
          //               rangeStartDay: DateTime.now(),
          //               rangeEndDay: DateTime.now().add(Duration(
          //                   days: livecontent
          //                       .contestQuestionModel.result!.length -
          //                       1)),
          //               // rangeEndDay: DateTime.now().add(Duration(days: 3)),
          //             ),
          //             const SizedBox(
          //               height: 20,
          //             ),
          //             const Text('Question'),
          //             Text(
          //               livecontent.contestQuestionModel.result!.isEmpty
          //                   ? 'No question'
          //                   : livecontent.contestQuestionModel.result![index]
          //                   .question!,
          //               maxLines: 2,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             if (livecontent.contestQuestionModel.result!.isNotEmpty)
          //               MyNetImage(
          //                   width: MediaQuery.of(context).size.width,
          //                   height: MediaQuery.of(context).size.height / 4,
          //                   fit: BoxFit.fill,
          //                   imagePath: livecontent.contestQuestionModel
          //                       .result![index].image ==
          //                       ""
          //                       ? 'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg?w=1060'
          //                       : livecontent.contestQuestionModel
          //                       .result![index].image!),
          //             const Spacer(
          //               flex: 3,
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 TextButton(
          //                   onPressed: () {
          //                     Navigator.pop(context);
          //                   },
          //                   child: const Text(
          //                     'Cancel',
          //                     style:
          //                     TextStyle(color: baseColor, fontSize: 20),
          //                   ),
          //                 ),
          //                 TextButton(
          //                   style: ButtonStyle(
          //                       backgroundColor:
          //                       MaterialStateProperty.all(cyan),
          //                       shape: MaterialStateProperty.all(
          //                           const RoundedRectangleBorder(
          //                               borderRadius: BorderRadius.all(
          //                                   Radius.circular(28.0))))),
          //                   onPressed: () async {
          //                     DateTime now = DateTime.now();
          //
          //                     debugPrint(
          //                         now.toLocal().toString().split(' ')[0] +
          //                             '  this is now');
          //                     debugPrint(
          //                         _selectedDay.toString().split(' ')[0] +
          //                             '  this is selected');
          //
          //                     if (now.toString().split(' ')[0] ==
          //                         _selectedDay.toString().split(' ')[0]) {
          //                       Utility.toastMessage(
          //                           ' Coming Soon Waiting For Api');
          //                       Navigator.pushReplacement(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) =>
          //                                   ContestQuestions(
          //                                     contestId: widget.questionId
          //                                         .toString(),
          //                                     contestName: widget.contestName,
          //                                   )));
          //                     } else {
          //                       Utility.toastMessage(
          //                           'No Matching With Selected Day \n Please Select '
          //                               'another question');
          //                     }
          //                   },
          //                   child: const Text(
          //                     'Confirm',
          //                     style: TextStyle(color: Colors.white),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             )
          //           ],
          //         ),
          //       );
          //     })
        );
      },
    );
  }
}
