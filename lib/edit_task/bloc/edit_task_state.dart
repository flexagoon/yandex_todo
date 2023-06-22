import 'package:flutter/material.dart';
import 'package:yandex_todo/app/models/task.dart';
import 'package:yandex_todo/app/models/task_priority.dart';

@immutable
final class EditTaskState {
  final EditTaskStatus status;
  final Task? initialTask;
  final String? text;
  final TaskPriority? priority;
  final DateTime? deadline;
  final bool deadlineEnabled;

  bool get isNewTask => initialTask == null;

  EditTaskState({
    this.initialTask,
    this.status = EditTaskStatus.idle,
  })  : text = initialTask?.text,
        priority = initialTask?.priority,
        deadline = initialTask?.deadline,
        deadlineEnabled = initialTask?.deadline != null;

  const EditTaskState._fromValues({
    required this.status,
    required this.initialTask,
    required this.text,
    required this.priority,
    required this.deadline,
    required this.deadlineEnabled,
  });

  EditTaskState copyWith({
    EditTaskStatus? status,
    Task? initialTask,
    String? text,
    TaskPriority? priority,
    DateTime? deadline,
    bool? hasDeadline,
  }) {
    return EditTaskState._fromValues(
      status: status ?? this.status,
      initialTask: initialTask ?? this.initialTask,
      text: text ?? this.text,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      deadlineEnabled: hasDeadline ?? deadlineEnabled,
    );
  }
}

enum EditTaskStatus {
  idle,
  done,
}
