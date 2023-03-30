import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanad/Cubit/app_cubit.dart';
import 'package:sanad/model/Statistics%20Model.dart';
import 'package:shimmer/shimmer.dart';

import '../../Theme/color.dart';
import '../../widget/MyAppbar.dart';
import '../../widget/myText.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);
  getAppbar() {
    return const MyAppbar(
      title: "Statistics",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStateCubit>(
      listener: (context, state) {},
      builder: (context, state) {
        // Size size = MediaQuery.of(context).size;
        var cubit = AppCubit.get(context);
        StatisticsModel? myModel = cubit.statisticsModel;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Statistics'),
            backgroundColor: Colors.white,
          ),
          body: state is StatisticsLoadingState
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 160,
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    );
                  },
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: cubit.statisticsModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 5, top: 10, right: 5, bottom: 0),
                            height: MediaQuery.of(context).size.height / 5,
                            decoration: const BoxDecoration(
                                color: cyan,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10, bottom: 5),
                              child: Column(children: [
                                Center(
                                  child: MyText(
                                      title:
                                          "Welcome ${myModel!.data![index].users![index].username} ",
                                      size: 18,
                                      fontWeight: FontWeight.bold,
                                      colors: Colors.white),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    // Image.network(
                                    //   "${myModel.data![index].contest![index].image}",
                                    //   height: 15,
                                    //   width: 15,
                                    // ),
                                    const SizedBox(width: 5),
                                    MyText(
                                        title:
                                            "${myModel.data![index].contest![index].name}",
                                        size: 16,
                                        fontWeight: FontWeight.w400,
                                        colors: Colors.white),
                                    const Spacer(),
                                    MyText(
                                      title:
                                          '${myModel.data![index].totalQuestions} Questions',
                                      colors: Colors.white,
                                      size: 16,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    MyText(
                                        title:
                                            "${myModel.data![index].contest![index].noOfRank} points",
                                        size: 16,
                                        fontWeight: FontWeight.w400,
                                        colors: Colors.white),
                                    const Spacer(),
                                    MyText(
                                      title:
                                          '${myModel.data![index].contest![index].price} price',
                                      colors: Colors.white,
                                      size: 16,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Spacer(),
                                const Divider(height: 1, color: textColorGrey),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyText(
                                          title:
                                              "Start : ${myModel.data![index].contest![index].startDate!.split(' ')[0]}",
                                          size: 16,
                                          fontWeight: FontWeight.w600,
                                          colors: Colors.white),
                                      const VerticalDivider(
                                        thickness: 2,
                                        width: 20,
                                        color: textColorGrey,
                                      ),
                                      MyText(
                                          title:
                                              "End : ${myModel.data![index].contest![index].endDate!.split(' ')[0]}",
                                          size: 16,
                                          fontWeight: FontWeight.w600,
                                          colors: Colors.white),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
