import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityType) {
      if (connectivityType == ConnectivityResult.wifi) {
        emitInternetConnected(InternetConnectionType.wifi);
      } else if (connectivityType == ConnectivityResult.mobile) {
        emitInternetConnected(InternetConnectionType.mobile);
      } else if (connectivityType == ConnectivityResult.none) {
        emitInternetDisconnected();
      } else {}
    });
  }

  void emitInternetConnected(InternetConnectionType internetConnectionType) {
    return emit(
      InternetConnected(internetConnectionType: internetConnectionType),
    );
  }

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
