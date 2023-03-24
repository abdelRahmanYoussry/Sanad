import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sanad/Cubit/BlocObserver.dart';
import 'package:sanad/Cubit/app_cubit.dart';
import 'package:sanad/pages/splash.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/provider/commanprovider.dart';
import 'package:sanad/utils/constant.dart';

import 'Network/dio_helper.dart';
import 'Theme/theme_model.dart';

bool? isviewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  FinalDioHelper.init();

  MobileAds.instance.initialize();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        name: "Sanad",
        options: const FirebaseOptions(
            apiKey: "AIzaSyByTvm1HE3aW-A1Ck7KnI8g4vNeWjpadjA",
            appId: "1:195912557536:android:d0625dc2aef4ad06590185",
            messagingSenderId: "195912557536",
            projectId: "sanad-8c7fb"));
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
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AppCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'home',
        home: const Splash(),
        theme: ThemeModel().lightMode, // Provide light theme.
        darkTheme: ThemeModel().darkMode,
      ),
    );
  }
}
