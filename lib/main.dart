import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/pages/splash.dart';
import 'package:quizapp/provider/apiprovider.dart';
import 'package:quizapp/provider/commanprovider.dart';
import 'Theme/theme_model.dart';

bool? isviewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
