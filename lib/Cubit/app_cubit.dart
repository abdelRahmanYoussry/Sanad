import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanad/Network/dio_helper.dart';
import 'package:sanad/Network/endpoints.dart';
import 'package:sanad/model/Statistics%20Model.dart';
import 'package:sanad/model/paypalmodel.dart';

import '../model/contentmodel.dart';
import '../webservice/apiservice.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStateCubit> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  PayPalModel? payPalModel;
  StatisticsModel? statisticsModel;
  String? paymentLink;
  ContentModel livecontentModel = ContentModel();

//?user_id=1&plan_subscription_id=1&transaction_amount=10&coin=100
  Future<void> getPayPalLink({
    required int userId,
    required int planSubscriptionId,
    required int transactionAmount,
    required int coin,
  }) async {
    emit(PayPalLoadingState());
    FinalDioHelper.postData(url: payPalUrl, dataTobody: {
      'user_id': userId,
      'plan_subscription_id': planSubscriptionId,
      'transaction_amount': transactionAmount,
      'coin': coin,
    }).then((value) async {
      payPalModel = PayPalModel.fromJson(value.data);
      print(payPalModel!.paymentLink);
      paymentLink = payPalModel!.paymentLink;

      emit(PayPalSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(PayPalErrorState());
    });
  }

  getLiveContent(
      {context, required String listType, required String userID}) async {
    livecontentModel = await ApiService().getContest(listType, userID);
    emit(GetLiveContentSuccessState());
    // debugPrint("${livecontentModel.status}");
  }

  getStatistics({required String userId}) {
    emit(StatisticsLoadingState());
    FinalDioHelper.getData(
      url: statisticsUrl + userId,
    ).then((value) {
      statisticsModel = StatisticsModel.fromJson(value.data);
      emit(StatisticsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(StatisticsErrorState());
    });
  }
}
