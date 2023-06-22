import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/data/tasks_repository.dart';
import 'package:yandex_todo/app/view/app_view.dart';

class App extends StatelessWidget {
  final TasksRepository tasksRepository;

  const App({
    required this.tasksRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: tasksRepository,
      child: const AppView(),
    );
  }
}
