import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Pages/questions.dart';
import 'package:quizapp/widget/myappbar.dart';
import 'package:quizapp/widget/myimage.dart';
import 'package:quizapp/widget/mytext.dart';

import '../Theme/color.dart';
import '../Theme/config.dart';

class Level extends StatefulWidget {
  const Level({Key? key}) : super(key: key);

  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.cover,
        ),
        borderRadius:
            BorderRadius.vertical(bottom: Radius.elliptical(50.0, 50.0)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MyAppbar(
            title: "Select Level",
          ),
        ),
        body: buildBody(),
      ),
    );
  }

  getAppbar() {
    return AppBar(
      title: const Text(
        "Select Level",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 14,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Questions()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyImage(
                          width: 80,
                          height: 80,
                          imagePath: 'assets/images/level_lock.png'),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          title: 'Level 1',
                          size: 16,
                          fontWeight: FontWeight.w500,
                          colors: textColor),
                      MyText(
                          title: 'Questions 21',
                          size: 16,
                          fontWeight: FontWeight.w500,
                          colors: textColor),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
