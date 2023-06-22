import 'package:flutter/material.dart';
import 'package:yandex_todo/app/view/custom_colors.dart';
import 'package:yandex_todo/edit_task/view/edit_task_screen.dart';
import 'package:yandex_todo/task_list/view/task_list_app_bar.dart';
import 'package:yandex_todo/task_list/view/task_list_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late final ScrollController _scrollController;

  double extent = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          extent = _scrollController.offset;
        });
      });
  }

  void _openNewTaskScreen(BuildContext context) {
    Navigator.of(context).push(EditTaskScreen.route());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            TaskListAppBar(
              extent: extent,
            ),
            const SliverToBoxAdapter(
              child: TaskListCard(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: CustomColors.of(context).blue,
        onPressed: () => _openNewTaskScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
