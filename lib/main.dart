import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/pages/splash.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/provider/commanprovider.dart';
import 'package:quizapp/utils/constant.dart';
import 'Theme/theme_model.dart';

bool? isviewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        name: "QuizApp",
        options: const FirebaseOptions(
            apiKey: "AIzaSyCLYCrYHmXv4X2U7IBKGdylYckTWuEoDrc",
            appId: "1:233870429546:android:90c541dd026112811b6913",
            messagingSenderId: "233870429546",
            projectId: "quizapp-cae00"));
  } else {
    await Firebase.initializeApp();
  }

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(Constant().oneSignalAppId);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint("Accepted permission: $accepted");
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => CommanProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'home',
      home: const Splash(),
      theme: ThemeModel().lightMode, // Provide light theme.
      darkTheme: ThemeModel().darkMode,
    );
  }
}
