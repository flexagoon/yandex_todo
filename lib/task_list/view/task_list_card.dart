import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/task_list/bloc/task_list_bloc.dart';
import 'package:yandex_todo/task_list/view/new_task_tile.dart';
import 'package:yandex_todo/task_list/view/task_tile.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskListBloc>().state;
    final tasks = state.completedTasksVisible
        ? state.tasks
        : state.tasks.where((task) => !task.isCompleted).toList();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, i) {
            return i < tasks.length ? TaskTile(tasks[i]) : const NewTaskTile();
          },
          itemCount: tasks.length + 1,
        ),
      ),
    );
  }
}
