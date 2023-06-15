import 'package:flutter_bloc/flutter_bloc.dart';

class Logger extends BlocObserver {
  @override
  // Метод onEvent должен принимать любой Bloc.
  // ignore: strict_raw_type
  void onEvent(Bloc bloc, Object? event) {
    print('Event ${event.runtimeType} added to ${bloc.runtimeType}');
    super.onEvent(bloc, event);
  }
}
