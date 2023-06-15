import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/data/tasks_repository.dart';
import 'package:yandex_todo/app/view/custom_colors.dart';
import 'package:yandex_todo/app/view/custom_text_colors.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_bloc.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_event.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_state.dart';
import 'package:yandex_todo/edit_task/view/deadline_picker.dart';
import 'package:yandex_todo/edit_task/view/priority_picker.dart';

class EditTaskScreen extends StatelessWidget {
  static Route<void> route({String? taskId}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => EditTaskBloc(
          repository: context.read<TasksRepository>(),
          taskId: taskId,
        ),
        child: const EditTaskScreen(),
      ),
      fullscreenDialog: true,
    );
  }

  const EditTaskScreen({super.key});

  void _editText(BuildContext context, String newText) {
    context.read<EditTaskBloc>().add(TaskTextChanged(newText));
  }

  void _saveTask(BuildContext context) {
    context.read<EditTaskBloc>().add(const TaskSaved());
  }

  void _deleteTask(BuildContext context) {
    context.read<EditTaskBloc>().add(const TaskDeleted());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<EditTaskBloc>().state;

    return BlocListener<EditTaskBloc, EditTaskState>(
      listener: (context, _) => Navigator.of(context).pop(),
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditTaskStatus.done,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => _saveTask(context),
              child: Text(
                'СОХРАНИТЬ',
                style: TextStyle(
                  color: CustomColors.of(context).blue,
                ),
              ),
            ),
          ],
          iconTheme: IconThemeData(
            color: CustomTextColors.of(context).primary,
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    initialValue: state.text,
                    decoration: const InputDecoration(
                      hintText: 'Что надо сделать...',
                      isDense: true,
                      border: InputBorder.none,
                      constraints: BoxConstraints(
                        minHeight: 104,
                      ),
                    ),
                    maxLines: null,
                    onChanged: (text) => _editText(context, text),
                  ),
                ),
              ),
            ),
            const PriorityPicker(),
            const Divider(
              indent: 16,
              endIndent: 16,
            ),
            const DeadlinePicker(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton.icon(
                onPressed: state.isNewTask ? null : () => _deleteTask(context),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (!states.contains(MaterialState.disabled)) {
                        return CustomColors.of(context).red;
                      }

                      return null;
                    },
                  ),
                  alignment: Alignment.centerLeft,
                ),
                icon: const Icon(Icons.delete),
                label: const Text('Удалить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
