part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class PayPalSuccessState extends AppState {}

class PayPalLoadingState extends AppState {}

class PayPalErrorState extends AppState {}
