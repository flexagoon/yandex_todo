import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_todo/app/models/task.dart';

@immutable
final class TasksRepository {
  // Реактивный репозиторий.
  final _tasksStreamController = BehaviorSubject<List<Task>>.seeded([]);
  Stream<List<Task>> get tasks => _tasksStreamController.asBroadcastStream();

  Task getTask(String? id) {
    final currentTasks = [..._tasksStreamController.value];

    return currentTasks.firstWhere((task) => task.id == id);
  }

  void setTask(Task newTask) {
    final currentTasks = [..._tasksStreamController.value];
    final taskIndex = currentTasks.indexWhere(newTask.hasSameId);

    if (taskIndex >= 0) {
      currentTasks[taskIndex] = newTask;
    } else {
      currentTasks.add(newTask);
    }

    _tasksStreamController.add(currentTasks);
  }

  void deleteTask(String id) {
    final newTasks = [..._tasksStreamController.value]
      ..removeWhere((task) => task.id == id);

    _tasksStreamController.add(newTasks);
  }
}
