import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class TasksLogger extends BlocObserver {
  final Logger _log = Logger('TasksLogger');

  @override
  // Метод onEvent должен принимать любой Bloc.
  // ignore: strict_raw_type
  void onEvent(Bloc bloc, Object? event) {
    _log.info('Event ${event.runtimeType} added to ${bloc.runtimeType}');
    super.onEvent(bloc, event);
  }
}
