part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final InternetConnectionType internetConnectionType;

  InternetConnected({required this.internetConnectionType});
}

class InternetDisconnected extends InternetState {}
