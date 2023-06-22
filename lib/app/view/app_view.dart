import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/data/tasks_repository.dart';
import 'package:yandex_todo/app/view/tasks_theme.dart';
import 'package:yandex_todo/task_list/bloc/task_list_bloc.dart';
import 'package:yandex_todo/task_list/bloc/task_list_event.dart';
import 'package:yandex_todo/task_list/view/task_list_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TaskListBloc(context.read<TasksRepository>())
          ..add(const TaskListRequested()),
        child: const TaskListScreen(),
      ),
      title: 'Yandex TODO',
      theme: TasksTheme.light,
      darkTheme: TasksTheme.dark,
    );
  }
}
