import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:quizapp/theme/color.dart';
import 'package:quizapp/widget/mytext.dart';
import '../widget/myappbar.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  _SpinWheelState createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final StreamController<int> controller = StreamController<int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        selected: controller.stream,
                        items: const [
                          FortuneItem(
                            child: Text(
                              '2000',
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
                              '1000',
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
                              '3000',
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
                              '4000',
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
                              '5000',
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
                              '6000',
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
                              '7000',
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
                              '8000',
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
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextButton(
                      onPressed: () {
                        controller.stream;
                      },
                      child: MyText(
                        title: "Spin",
                        colors: white,
                        fontWeight: FontWeight.w500,
                        size: 18,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side:
                                          const BorderSide(color: primary))))),
                )
              ],
            ),
          )),
    );
  }
}
