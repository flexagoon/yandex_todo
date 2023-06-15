import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:yandex_todo/app/app.dart';
import 'package:yandex_todo/app/data/tasks_repository.dart';
import 'package:yandex_todo/logger.dart';

void main() {
  Bloc.transformer = restartable();
  Bloc.observer = Logger();

  final tasksRepository = TasksRepository();

  Intl.defaultLocale = 'ru';
  initializeDateFormatting('ru');

  runApp(App(tasksRepository: tasksRepository));
}
