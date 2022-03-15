import 'package:flutter/material.dart';

class Config {
  final String appName = 'Quiz App';

  final String doneAsset = 'assets/done.json';
  final Color appColor = Color(0xff681FA9);
  final Color appDarkColor = Color(0xff681FA9);
  final Color appaccentColor = Color(0xff999999);

  //Intro images
  final String introImage1 = 'assets/news1.png';
  final String introImage2 = 'assets/news6.png';
  final String introImage3 = 'assets/news7.png';

  final String userAvatar =
      'https://image.flaticon.com/icons/png/512/149/149071.png';
  // Ads Setup

  //-- admob ads -- (you can use this ids for testing purposes)
  final String admobAppId = 'ca-app-pub-3940256099942544~3347511713';

  final String admobInterstitialAdIdAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  final String admobInterstitialAdIdiOS =
      'ca-app-pub-3940256099942544/1033173712';

  final String admobBannerAdIdAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  final String admobBannerAdIdiOS = 'ca-app-pub-3940256099942544/6300978111';

  //fb ads (you can't use this ids)
  final String fbInterstitalAdIDAndroid = '54451484650202************';
  final String fbInterstitalAdIDiOS = '544514846502023_7023************';

  final String fbBannerAdIdAndroid = '544514846502023_7************';
  final String fbBannerAdIdiOS = '544514846502023_7023************';

  final String razorPay = 'rzp_test_LWiib9g5hWPQDj';

  final String baseurl = 'https://divinetechs.com/envato/app/quiz';
}
