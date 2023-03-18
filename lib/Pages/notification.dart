import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanad/provider/apiprovider.dart';
import 'package:sanad/theme/color.dart';
import 'package:sanad/utils/sharepref.dart';
import 'package:sanad/utils/utility.dart';
import 'package:sanad/widget/mytext.dart';
import '../widget/myappbar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String? userId;
  SharePref sharePref = SharePref();

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    userId = await sharePref.read('userId') ?? "0";
    debugPrint('userID===>${userId.toString()}');

    final notificationProvider =
        Provider.of<ApiProvider>(context, listen: false);
    notificationProvider.getNotification(context, userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [getAppbar(), const SizedBox(height: 30), buildWebview()],
          ),
        ),
      ),
    );
  }

  getAppbar() {
    return const MyAppbar(
      title: "Notification",
    );
  }

  buildWebview() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        child: Container(
          color: white,
          child: Consumer<ApiProvider>(
            builder: (context, notificationData, child) {
              if (notificationData.loading) {
                return Center(child: CircularProgressIndicator(value: 10));
              } else {
                if (notificationData.notificationModel.status == 200 &&
                    notificationData.notificationModel.result!.isNotEmpty) {
                  return ListView.builder(
                    itemCount:
                        notificationData.notificationModel.result?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 3,
                          color: lightgray,
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              CircleAvatar(
                                  radius: (20),
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                        "assets/images/ic_quiz.png"),
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      title: notificationData.notificationModel
                                          .result?[index].headings
                                          .toString(),
                                      maxline: 1,
                                      fontWeight: FontWeight.w800,
                                      size: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 3),
                                    MyText(
                                      title: notificationData.notificationModel
                                          .result?[index].contents
                                          .toString(),
                                      maxline: 2,
                                      fontWeight: FontWeight.w400,
                                      size: 13,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () async {
                                  var notificationProvider =
                                      Provider.of<ApiProvider>(context,
                                          listen: false);

                                  await notificationProvider
                                      .getReadNotification(
                                          userId,
                                          notificationData.notificationModel
                                              .result?[index].id);
                                  if (!notificationProvider.loading) {
                                    Utility.toastMessage("Success");
                                    notificationProvider.getNotification(
                                        context, userId);
                                  }
                                },
                                child: CircleAvatar(
                                    radius: 15,
                                    child: ClipRRect(
                                      child: Image.asset(
                                          "assets/images/ic_del.png"),
                                    )),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                      child: SizedBox(
                          child: MyText(
                    title: "Notification not found",
                    fontWeight: FontWeight.w800,
                    size: 20,
                  )));
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
