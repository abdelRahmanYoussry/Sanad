import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Model/GeneralSettingModel.dart';
import 'package:quizapp/Theme/color.dart';
import 'package:quizapp/webservice/api_provider.dart';
import 'package:quizapp/webservice/apiservice.dart';
import 'package:quizapp/widget/CustomAppbar.dart';

class TestApi extends StatelessWidget {
  const TestApi({Key? key}) : super(key: key);

  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<ApiProvider>(context, listen: reload)
        .fetchgeneralSettings(context);
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context, false);

    return Scaffold(
      backgroundColor: appColor,
      body: Consumer<ApiProvider>(
        builder: (context, value, child) {
          return Center(child: Text('Name : ${value.generalSettingModel}'));
        },
      ),
    );
  }
}
