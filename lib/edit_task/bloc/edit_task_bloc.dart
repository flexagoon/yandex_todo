import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/data/tasks_repository.dart';
import 'package:yandex_todo/app/models/task.dart';
import 'package:yandex_todo/app/models/task_priority.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_event.dart';
import 'package:yandex_todo/edit_task/bloc/edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  final TasksRepository repository;

  EditTaskBloc({required this.repository, String? taskId})
      : super(
          EditTaskState(
            initialTask: taskId == null ? null : repository.getTask(taskId),
          ),
        ) {
    on<EditTaskEvent>(
      (event, emit) => switch (event) {
        TaskTextChanged() => _onTaskTextChanged(event, emit),
        TaskPriorityChanged() => _onTaskPriorityChanged(event, emit),
        TaskDeadlineChanged() => _onTaskDeadlineChanged(event, emit),
        TaskDeadlineToggled() => _onTaskDeadlineToggled(event, emit),
        TaskSaved() => _onTaskSaved(emit),
        TaskDeleted() => _onTaskDeleted(emit),
      },
    );
  }

  void _onTaskTextChanged(TaskTextChanged event, Emitter<EditTaskState> emit) {
    emit(state.copyWith(text: event.newText));
  }

  void _onTaskPriorityChanged(
    TaskPriorityChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(priority: event.newPriority));
  }

  void _onTaskDeadlineChanged(
    TaskDeadlineChanged event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(deadline: event.newDeadline));
  }

  void _onTaskDeadlineToggled(
    TaskDeadlineToggled event,
    Emitter<EditTaskState> emit,
  ) {
    emit(state.copyWith(hasDeadline: event.newValue));
  }

  Task _generateFinalTask() {
    final task = state.initialTask != null
        ? state.initialTask!.copyWith(
            text: state.text,
            priority: state.priority,
            deadline: state.deadline,
          )
        : Task(
            text: state.text ?? '',
            priority: state.priority ?? TaskPriority.normal,
            deadline: state.deadline,
          );

    return state.deadlineEnabled ? task : task.withoutDeadline();
  }

  void _onTaskSaved(Emitter<EditTaskState> emit) {
    final task = _generateFinalTask();

    repository.setTask(task);

    emit(
      state.copyWith(
        status: EditTaskStatus.done,
      ),
    );
  }

  void _onTaskDeleted(Emitter<EditTaskState> emit) {
    if (state.initialTask == null) return;

    repository.deleteTask(state.initialTask!.id);

    emit(
      state.copyWith(
        status: EditTaskStatus.done,
      ),
    );
  }
}
