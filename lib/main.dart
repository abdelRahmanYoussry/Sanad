import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/Pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/onboaring.dart';
import 'Theme/theme_model.dart';

bool? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = (prefs.getBool('seen') ?? false);
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('es'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
    useOnlyLangCode: true,
    child: const MyApp(),
  ));
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'home',
      home: isviewed != true ? const OnBoardingPage() : const Login(),
      theme: ThemeModel().lightMode, // Provide light theme.
      darkTheme: ThemeModel().darkMode,
    );
  }
}
