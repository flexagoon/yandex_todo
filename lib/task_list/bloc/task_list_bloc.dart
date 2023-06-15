import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/data/tasks_repository.dart';
import 'package:yandex_todo/task_list/bloc/task_list_event.dart';
import 'package:yandex_todo/task_list/bloc/task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TasksRepository repository;

  TaskListBloc(this.repository) : super(TaskListState()) {
    on<TaskListRequested>((_, emit) => _onTaskListRequested(emit));
    on<TaskListEvent>(
      (event, emit) => switch (event) {
        TaskListRequested() => null,
        TaskCompletionToggled() => _onTaskCompletionToggled(event),
        TaskDeleted() => _onTaskDeleted(event),
        CompletedTaskVisibilityToggled() =>
          _onCompletedTaskVisibilityToggled(event, emit),
      },
    );
  }

  Future<void> _onTaskListRequested(Emitter<TaskListState> emit) async {
    await emit.forEach(
      repository.tasks,
      onData: (tasks) => state.copyWith(tasks: tasks),
    );
  }

  void _onTaskCompletionToggled(TaskCompletionToggled event) {
    final task = repository.getTask(event.id);
    final newTask = task.copyWith(isCompleted: event.value);
    repository.setTask(newTask);
  }

  void _onTaskDeleted(TaskDeleted event) {
    repository.deleteTask(event.id);
  }

  void _onCompletedTaskVisibilityToggled(
    CompletedTaskVisibilityToggled event,
    Emitter<TaskListState> emit,
  ) {
    emit(state.copyWith(completedTasksVisible: event.value));
  }
}
