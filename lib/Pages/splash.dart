import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanad/pages/home.dart';
import 'package:sanad/pages/login/login.dart';
import 'package:sanad/pages/onboaring.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/utils/adhelper.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/widget/myimage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  String? seen;
  int? index;
  SharePref sharePref = SharePref();
  // ignore: prefer_typing_uninitialized_variables
  @override
  initState() {
    getGeneral();
    AdHelper.getAds();
    super.initState();
  }

  getGeneral() async {
    final bannerdata = Provider.of<ApiProvider>(context, listen: false);
    await bannerdata.getGeneralsetting(context);
    if (!bannerdata.loading) {
      for (var i = 0; i < bannerdata.generalSettingModel.result!.length; i++) {
        // debugPrint(
        //     '===>${bannerdata.generalSettingModel.result?[i].key} ===> ${bannerdata.generalSettingModel.result?[i].value}');
        await sharePref.save(
            bannerdata.generalSettingModel.result?[i].key ?? "",
            bannerdata.generalSettingModel.result?[i].value ?? "");
      }
      idFirstChack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: MyImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
            imagePath: "assets/images/splash.png"),
      ),
    );
  }

  idFirstChack() async {
    seen = await sharePref.read('seen') ?? "0";
    String isLogin = await sharePref.read('is_login') ?? "0";
    // debugPrint('seen===>$seen');
    if (seen == "1") {
      if (isLogin == "1") {
        // debugPrint('isLogin home===>$isLogin');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Home();
            },
          ),
        );
      } else {
        // debugPrint('isLogin login===>$isLogin');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Login();
            },
          ),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const OnBoardingPage();
          },
        ),
      );
    }
  }
}
