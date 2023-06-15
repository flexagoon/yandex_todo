import 'package:flutter/material.dart';
import 'package:yandex_todo/app/models/task.dart';

@immutable
final class TaskListState {
  final List<Task> tasks;
  final bool completedTasksVisible;

  int get completedCount => tasks.where((task) => task.isCompleted).length;

  TaskListState({
    List<Task>? tasks,
    this.completedTasksVisible = true,
  }) : tasks = tasks ?? [Task(text: 'test')];

  TaskListState copyWith({
    List<Task>? tasks,
    bool? completedTasksVisible,
  }) {
    return TaskListState(
      tasks: tasks ?? this.tasks,
      completedTasksVisible:
          completedTasksVisible ?? this.completedTasksVisible,
    );
  }
}
