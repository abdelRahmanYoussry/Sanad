import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/Theme/config.dart';
import 'package:quizapp/pages/login.dart';
import 'package:quizapp/utils/sharepref.dart';
import 'package:quizapp/widget/myimage.dart';
import 'package:quizapp/widget/mytext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  SharePref sharePref = SharePref();

  List<String> introBigtext = <String>[
    "Participate in quiz and win the price also learn",
    "Participate in contest and win the price also learn",
    "Add Wallet and cash Withdrawal",
    "Multiple Challenge with other participate",
  ];

  List<String> introSmalltext = <String>[
    "Lörem ipsum hexaren lura infrasysam, utan preguras. Gyk kron hade pokaling. Nätdeklarant kvasin i full planat.Monodis dins. Rear hexaledes. Spera prelande polysasera för att gyling. ",
    "Lörem ipsum hexaren lura infrasysam, utan preguras. Gyk kron hade pokaling. Nätdeklarant kvasin i full planat.Monodis dins. Rear hexaledes. Spera prelande polysasera för att gyling. ",
    "Lörem ipsum hexaren lura infrasysam, utan preguras. Gyk kron hade pokaling. Nätdeklarant kvasin i full planat.Monodis dins. Rear hexaledes. Spera prelande polysasera för att gyling. ",
    "Lörem ipsum hexaren lura infrasysam, utan preguras. Gyk kron hade pokaling. Nätdeklarant kvasin i full planat.Monodis dins. Rear hexaledes. Spera prelande polysasera för att gyling. ",
  ];

  List<String> icons = <String>[
    "assets/images/ic_intro1.png",
    "assets/images/ic_intro2.png",
    "assets/images/ic_intro3.png",
    "assets/images/ic_intro4.png",
  ];

  PageController pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  int pos = 0;

  _storeOnboardInfo() async {
    sharePref.save('seen', "1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: white,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/intro1.png'),
                                fit: BoxFit.fill)),
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          itemCount: introBigtext.length,
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.all(70),
                                child: MyImage(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    imagePath: icons[index]),
                              ),
                            );
                          },
                          onPageChanged: (index) {
                            pos = index;
                            currentPageNotifier.value = index;
                            debugPrint("pos:$pos");
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DotsIndicator(
                                dotsCount: introBigtext.length,
                                position: pos.toDouble(),
                                decorator: DotsDecorator(
                                  size: const Size.square(7.0),
                                  activeSize: const Size(18.0, 6.0),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const Spacer(),
                              MyText(
                                  colors: primary,
                                  maxline: 2,
                                  title: introBigtext[pos],
                                  textalign: TextAlign.center,
                                  size: 20,
                                  fontWeight: FontWeight.w600,
                                  fontstyle: FontStyle.normal),
                              const Spacer(),
                              MyText(
                                  colors: secondary,
                                  maxline: 5,
                                  title: introSmalltext[pos],
                                  textalign: TextAlign.center,
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  fontstyle: FontStyle.normal),
                              const Spacer(),
                              SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width - 100,
                                child: TextButton(
                                    child: MyText(
                                      title: pos == introBigtext.length - 1
                                          ? "FINISH"
                                          : "NEXT",
                                      colors: white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    style: ButtonStyle(
                                        padding:
                                            MaterialStateProperty.all<EdgeInsets>(
                                                const EdgeInsets.all(5)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                primary),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                    color: primary)))),
                                    onPressed: () => {
                                          if (pos == introBigtext.length - 1)
                                            {
                                              _storeOnboardInfo(),
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const Login()))
                                            }
                                          else
                                            {
                                              pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease)
                                            }
                                        }),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  _storeOnboardInfo();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const Login()));
                                },
                                child: MyText(
                                    colors: secondary,
                                    maxline: 1,
                                    title: 'Skip',
                                    textalign: TextAlign.center,
                                    size: 14,
                                    fontWeight: FontWeight.w600,
                                    fontstyle: FontStyle.normal),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
