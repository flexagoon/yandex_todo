import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yandex_todo/app/view/custom_colors.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_bloc.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_event.dart';

class DeadlinePicker extends StatelessWidget {
  const DeadlinePicker({super.key});

  Future<void> _pickDeadline(BuildContext context) async {
    final bloc = context.read<EditTaskBloc>();
    final currentDeadline = bloc.state.deadline;

    final deadline = await showDatePicker(
      context: context,
      initialDate: currentDeadline ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (deadline != null) {
      bloc.add(TaskDeadlineChanged(deadline));
    }
  }

  void _toggleDeadline(BuildContext context, bool value) {
    context.read<EditTaskBloc>().add(TaskDeadlineToggled(value));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTaskBloc>().state;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => state.deadlineEnabled ? _pickDeadline(context) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Сделать до'),
                if (state.deadlineEnabled)
                  Text(
                    state.deadline != null
                        ? DateFormat.yMMMMd().format(state.deadline!)
                        : 'Выберите дату',
                    style: TextStyle(
                      color: CustomColors.of(context).blue,
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: state.deadlineEnabled,
            onChanged: (value) => _toggleDeadline(context, value),
          ),
        ],
      ),
    );
  }
}
