import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanad/Network/dio_helper.dart';
import 'package:sanad/Network/endpoints.dart';
import 'package:sanad/model/paypalmodel.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  PayPalModel? payPalModel;
  String? paymentLink;
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
}
