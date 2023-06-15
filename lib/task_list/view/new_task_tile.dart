import 'package:flutter/material.dart';
import 'package:yandex_todo/app/view/custom_text_colors.dart';
import 'package:yandex_todo/edit_task/view/edit_task_screen.dart';

class NewTaskTile extends StatelessWidget {
  const NewTaskTile({super.key});

  void _openNewTaskScreen(BuildContext context) {
    Navigator.of(context).push(EditTaskScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    final textColor = CustomTextColors.of(context).tertiary;

    return ListTile(
      leading: const SizedBox.shrink(),
      title: const Text('Новое'),
      textColor: textColor,
      onTap: () => _openNewTaskScreen(context),
    );
  }
}
