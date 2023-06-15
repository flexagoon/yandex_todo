import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yandex_todo/app/models/task.dart';
import 'package:yandex_todo/app/models/task_priority.dart';
import 'package:yandex_todo/app/view/custom_colors.dart';
import 'package:yandex_todo/app/view/custom_text_colors.dart';
import 'package:yandex_todo/edit_task/view/edit_task_screen.dart';
import 'package:yandex_todo/task_list/bloc/task_list_bloc.dart';
import 'package:yandex_todo/task_list/bloc/task_list_event.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile(this.task, {super.key});

  Future<bool> _handleTileSwipe(
    BuildContext context,
    DismissDirection direction,
  ) async {
    if (direction == DismissDirection.startToEnd) {
      _toggleCompleted(context, !task.isCompleted);

      return false;
    } else {
      _deleteTask(context);

      return true;
    }
  }

  void _toggleCompleted(BuildContext context, bool value) {
    context.read<TaskListBloc>().add(
          TaskCompletionToggled(
            id: task.id,
            value: value,
          ),
        );
  }

  void _deleteTask(BuildContext context) {
    context.read<TaskListBloc>().add(TaskDeleted(task.id));
  }

  void _editTask(BuildContext context) {
    Navigator.of(context).push(EditTaskScreen.route(taskId: task.id));
  }

  @override
  Widget build(BuildContext context) {
    final customColors = CustomColors.of(context);
    final red = customColors.red;
    final green = customColors.green;

    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Dismissible(
      key: Key(task.id),
      background: ColoredBox(
        color: green,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
      secondaryBackground: ColoredBox(
        color: red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) => _handleTileSwipe(context, direction),
      child: CheckboxListTile(
        value: task.isCompleted,
        onChanged: (value) => _toggleCompleted(context, value!),
        activeColor: green,
        fillColor: task.priority == TaskPriority.high
            ? MaterialStateProperty.resolveWith((states) {
                if (!states.contains(MaterialState.selected)) {
                  return Colors.red;
                }

                return null;
              })
            : null,
        title: RichText(
          text: TextSpan(
            style: textStyle,
            children: [
              if (task.priority == TaskPriority.high)
                TextSpan(
                  text: '!!',
                  style: TextStyle(
                    color: red,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              if (task.priority == TaskPriority.low)
                WidgetSpan(
                  child: SizedBox(
                    child: Icon(
                      Icons.arrow_downward,
                      size: textStyle.fontSize,
                    ),
                  ),
                ),
              if (task.priority != TaskPriority.normal)
                const WidgetSpan(
                  child: SizedBox(
                    width: 2,
                  ),
                ),
              TextSpan(
                text: task.text,
                style: task.isCompleted
                    ? TextStyle(
                        color: CustomTextColors.of(context).tertiary,
                        decoration: TextDecoration.lineThrough,
                      )
                    : null,
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        subtitle: task.deadline != null
            ? Text(DateFormat.yMMMMd().format(task.deadline!))
            : null,
        secondary: IconButton(
          onPressed: () => _editTask(context),
          icon: const Icon(Icons.info_outline),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
