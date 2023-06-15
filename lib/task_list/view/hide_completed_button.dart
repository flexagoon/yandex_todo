import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/view/custom_colors.dart';
import 'package:yandex_todo/task_list/bloc/task_list_bloc.dart';
import 'package:yandex_todo/task_list/bloc/task_list_event.dart';

class HideCompletedButton extends StatelessWidget {
  final bool hasPadding;

  const HideCompletedButton({this.hasPadding = true, super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskListBloc>().state;

    return IconButton(
      padding: hasPadding ? null : EdgeInsets.zero,
      onPressed: () => context.read<TaskListBloc>().add(
            CompletedTaskVisibilityToggled(
              value: !state.completedTasksVisible,
            ),
          ),
      constraints: hasPadding ? null : const BoxConstraints(),
      icon: Icon(
        state.completedTasksVisible ? Icons.visibility_off : Icons.visibility,
        color: CustomColors.of(context).blue,
      ),
    );
  }
}
