import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/Pages/login.dart';
import 'package:quizapp/Theme/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPage = 3;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPage; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? Config().appaccentColor : Config().appDarkColor,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  _storeOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/introscreen/intro1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 10, right: 80),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Best Place to Find everything you need',
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.normal,
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 24.0,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 80),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Bollywood diva of dance is back on small screen judging So You Think You Can Dance:',
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.normal,
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16.0,
                                decoration: TextDecoration.none,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
              Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/introscreen/intro2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 10, right: 80),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Best Place to Find everything you need',
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.normal,
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 24.0,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 80),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Bollywood diva of dance is back on small screen judging So You Think You Can Dance:',
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.normal,
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16.0,
                                decoration: TextDecoration.none,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
              Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/introscreen/intro3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 10, right: 80),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Best Place to Find everything you need',
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.normal,
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 24.0,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 80),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Bollywood diva of dance is back on small screen judging So You Think You Can Dance:',
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.normal,
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 16.0,
                                decoration: TextDecoration.none,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
        Stack(
          children: [
            Positioned(
                right: 10.0,
                bottom: 20.0,
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Config().appColor, // background
                      onPrimary: Config().appColor,
                      shadowColor: Config().appaccentColor,
                    ),
                    onPressed: () {
                      if (_currentPage == _numPage - 1) {
                        _storeOnboardInfo();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => const Login()));
                      } else {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _currentPage != _numPage - 1 ? 'Next' : 'Done',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                )),
            Positioned.fill(
                bottom: 30.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                )),
            Positioned(
                left: 10.0,
                bottom: 20.0,
                child: GestureDetector(
                  onTap: () {
                    _storeOnboardInfo();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => const Login()));
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Config().appaccentColor,
                          fontSize: 18.0,
                          decoration: TextDecoration.none),
                    ),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
