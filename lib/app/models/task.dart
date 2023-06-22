import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_todo/app/models/task_priority.dart';

@immutable
final class Task {
  final String id;
  final String text;
  final bool isCompleted;
  final TaskPriority priority;
  final DateTime? deadline;

  Task({
    required this.text,
    this.isCompleted = false,
    this.priority = TaskPriority.normal,
    this.deadline,
  }) : id = const Uuid().v4();

  const Task._withId({
    required this.id,
    required this.text,
    this.isCompleted = false,
    this.priority = TaskPriority.normal,
    this.deadline,
  });

  bool hasSameId(Task other) => id == other.id;

  Task copyWith({
    String? text,
    bool? isCompleted,
    TaskPriority? priority,
    DateTime? deadline,
  }) {
    return Task._withId(
      id: id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
    );
  }

  Task withoutDeadline() {
    return Task._withId(
      id: id,
      text: text,
      isCompleted: isCompleted,
      priority: priority,
    );
  }
}
