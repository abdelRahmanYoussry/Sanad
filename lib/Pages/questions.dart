import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/widget/myText.dart';

import '../Theme/color.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final CustomTimerController _controller = CustomTimerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.start();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/appbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              getAppbar(),
              SizedBox(
                height: 100,
                child: CustomTimer(
                    controller: _controller,
                    begin: const Duration(seconds: 30),
                    end: const Duration(seconds: 0),
                    builder: (remaining) {
                      return Text("${remaining.seconds}",
                          style: const TextStyle(fontSize: 24.0));
                    }),
              ),
              ClipRRect(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/login_bg_white.png"),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // #signup_button
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  getAppbar() {
    return AppBar(
      title: Text(
        "Level 1",
        style: GoogleFonts.poppins(
            color: white, fontSize: 22, fontWeight: FontWeight.w500),
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
    );
  }
}
