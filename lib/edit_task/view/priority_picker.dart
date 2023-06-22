import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/models/task_priority.dart';
import 'package:yandex_todo/app/view/custom_text_colors.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_bloc.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_event.dart';
import 'package:yandex_todo/edit_task/view/high_priority_text.dart';

class PriorityPicker extends StatelessWidget {
  const PriorityPicker({super.key});

  void _setPriority(BuildContext context, TaskPriority priority) {
    context.read<EditTaskBloc>().add(TaskPriorityChanged(priority));
  }

  @override
  Widget build(BuildContext context) {
    final currentPriority =
        context.watch<EditTaskBloc>().state.priority ?? TaskPriority.normal;

    return PopupMenuButton(
      itemBuilder: (_) => [
        const PopupMenuItem<TaskPriority>(
          value: TaskPriority.normal,
          child: Text('Нет'),
        ),
        const PopupMenuItem<TaskPriority>(
          value: TaskPriority.low,
          child: Text('Низкая'),
        ),
        const PopupMenuItem<TaskPriority>(
          value: TaskPriority.high,
          child: HighPriorityText(),
        ),
      ],
      initialValue: currentPriority,
      onSelected: (priority) => _setPriority(context, priority),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Важность'),
            if (currentPriority == TaskPriority.high) const HighPriorityText(),
            if (currentPriority != TaskPriority.high)
              Text(
                switch (currentPriority) {
                  TaskPriority.normal => 'Нет',
                  TaskPriority.low => 'Низкая',
                  TaskPriority.high => 'Высокая',
                },
                style: TextStyle(
                  color: CustomTextColors.of(context).tertiary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
