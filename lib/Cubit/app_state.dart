part of 'app_cubit.dart';

@immutable
abstract class AppStateCubit {}

class AppInitial extends AppStateCubit {}

class PayPalSuccessState extends AppStateCubit {}

class PayPalLoadingState extends AppStateCubit {}

class PayPalErrorState extends AppStateCubit {}

class GetLiveContentSuccessState extends AppStateCubit {}

class StatisticsSuccessState extends AppStateCubit {}

class StatisticsLoadingState extends AppStateCubit {}

class StatisticsErrorState extends AppStateCubit {}
