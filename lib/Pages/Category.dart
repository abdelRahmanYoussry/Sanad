import 'package:flutter/material.dart';
import 'package:quizapp/Pages/level.dart';
import 'package:quizapp/widget/myappbar.dart';
import 'package:quizapp/widget/myimage.dart';
import 'package:quizapp/widget/mytext.dart';

import '../Theme/color.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MyAppbar(
            title: "Category",
          ),
        ),
        body: SafeArea(
          child: buildBody(),
        ),
      ),
    );
  }

  getAppbar() {
    return const MyAppbar(
      title: "Category",
    );
  }

  buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GridView.builder(
          padding: EdgeInsets.zero, // set padding to zero
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 12,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Level()));
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                        width: 80,
                        height: 80,
                        imagePath: 'assets/images/category1.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                        title: 'Category 1',
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
                        blurRadius: 5.0,
                      ),
                    ]),
              ),
            );
          }),
    );
  }
}
