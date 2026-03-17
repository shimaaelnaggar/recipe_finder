import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('On Change : ${bloc.runtimeType}');
    }
    if (kDebugMode) {
      print('current State : ${change.currentState}');
    }
    if (kDebugMode) {
      print('next state ${change.nextState}');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('On Error : ${bloc.runtimeType}');
    }
    if (kDebugMode) {
      print('error : $error');
    }
    super.onError(bloc, error, stackTrace);
  }
}
