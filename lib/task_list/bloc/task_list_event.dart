import 'package:flutter/material.dart';

@immutable
sealed class TaskListEvent {
  const TaskListEvent();
}

class TaskListRequested extends TaskListEvent {
  const TaskListRequested();
}

class TaskCompletionToggled extends TaskListEvent {
  final String id;
  final bool value;

  const TaskCompletionToggled({
    required this.id,
    required this.value,
  });
}

class TaskDeleted extends TaskListEvent {
  final String id;

  const TaskDeleted(this.id);
}

class CompletedTaskVisibilityToggled extends TaskListEvent {
  final bool value;

  const CompletedTaskVisibilityToggled({required this.value});
}
