import 'package:flutter/material.dart';
import 'package:yandex_todo/app/models/task_priority.dart';

@immutable
sealed class EditTaskEvent {
  const EditTaskEvent();
}

class TaskTextChanged extends EditTaskEvent {
  final String newText;

  const TaskTextChanged(this.newText);
}

class TaskPriorityChanged extends EditTaskEvent {
  final TaskPriority newPriority;

  const TaskPriorityChanged(this.newPriority);
}

class TaskDeadlineChanged extends EditTaskEvent {
  final DateTime newDeadline;

  const TaskDeadlineChanged(this.newDeadline);
}

class TaskDeadlineToggled extends EditTaskEvent {
  final bool newValue;

  // В данном контексте понятно, что означает булевый флаг.
  // ignore: avoid_positional_boolean_parameters
  const TaskDeadlineToggled(this.newValue);
}

class TaskSaved extends EditTaskEvent {
  const TaskSaved();
}

class TaskDeleted extends EditTaskEvent {
  const TaskDeleted();
}
