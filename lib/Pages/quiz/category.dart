import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sanad/model/categorymodel.dart';
import 'package:sanad/pages/quiz/level.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/theme/color.dart';
import 'package:sanad/utils/adhelper.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/widget/myappbar.dart';
import 'package:sanad/widget/mytext.dart';
import 'package:sanad/widget/mynetimage.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  SharePref sharePref = SharePref();
  List<Result>? categoryList = [];

  @override
  initState() {
    final categorydata = Provider.of<ApiProvider>(context, listen: false);
    categorydata.getCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categorydata = Provider.of<ApiProvider>(context);
    if (!categorydata.loading) {
      debugPrint('category===>$categorydata');
      categoryList = categorydata.categoryModel.result as List<Result>;
      debugPrint(categoryList?.length.toString());
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: categorydata.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
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
    return Column(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: GridView.builder(
                padding: EdgeInsets.zero, // set padding to zero
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: categoryList?.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Level(
                                catId: categoryList![index].id.toString(),
                              )));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyNetImage(
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              imagePath: categoryList?[index].image ?? ""),
                          const SizedBox(
                            height: 10,
                          ),
                          MyText(
                              title: categoryList?[index].name ?? "",
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
          ),
        ),
        SizedBox(
          height: 60,
          child:
              AdWidget(ad: AdHelper.createBannerAd()..load(), key: UniqueKey()),
        ),
      ],
    );
  }
}
