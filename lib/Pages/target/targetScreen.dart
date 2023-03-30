import 'package:flutter/material.dart';
import 'package:sanad/model/contestquestionmodel.dart';
import 'package:sanad/pages/calenderPage/calenderScreen.dart';
import 'package:sanad/utils/utility.dart';

import '../../Theme/color.dart';
import '../../Theme/config.dart';

class TargetScreen extends StatefulWidget {
  TargetScreen({
    Key? key,
    required this.result,
    required this.contestName,
    required this.questionId,
  }) : super(key: key);
  Result? result;
  String questionId, contestName;
  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalenderScreen(
                                  questionId: widget.questionId,
                                  contestName: widget.contestName,
                                ))),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Target",
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 2),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login_bg_white.png"),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.result!.question!),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: answerController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: "Answer",
                                labelStyle: TextStyle(color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: "Answer",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          Divider(
                            thickness: 0.5,
                            height: size.height * 0.01,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (answerController.text.isNotEmpty) {
                                double target =
                                    int.parse(answerController.text) /
                                        int.parse(widget.result!.target!)
                                            .toInt() *
                                        int.parse(widget.result!.pricePoint!)
                                            .toInt();
                                Utility.customShowDialog(
                                    title: const Text('Congratulation'),
                                    content: Text(
                                        ' You Have Won  ${target.round()} points'),
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
                              }
                            },
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width / 1.4,
                            shape: const StadiumBorder(),
                            color: Config().appColor,
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
