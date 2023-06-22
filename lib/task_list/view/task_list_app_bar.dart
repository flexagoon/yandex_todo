import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo/app/view/custom_text_colors.dart';
import 'package:yandex_todo/task_list/bloc/task_list_bloc.dart';
import 'package:yandex_todo/task_list/view/hide_completed_button.dart';

class TaskListAppBar extends StatelessWidget {
  final double extent;

  const TaskListAppBar({
    required this.extent,
    super.key,
  });

  double _calculatePadding({
    required double min,
    required double max,
    required double extent,
    required double maxExtent,
  }) {
    return max - (max - min) * (extent / maxExtent);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskListBloc>().state;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    const expandedHeight = 164.0;
    const collapsedHeight = expandedHeight - kToolbarHeight;
    final adjustedExtent = extent.clamp(0, collapsedHeight).toDouble();

    final leftPadding = _calculatePadding(
      min: 16,
      max: 60,
      extent: adjustedExtent,
      maxExtent: collapsedHeight,
    );
    final bottomPadding = _calculatePadding(
      min: 0,
      max: 18,
      extent: adjustedExtent,
      maxExtent: collapsedHeight,
    );
    final titlePadding = _calculatePadding(
      min: 16,
      max: 22,
      extent: adjustedExtent,
      maxExtent: collapsedHeight,
    );

    return SliverAppBar(
      actions: [
        if (adjustedExtent == collapsedHeight) const HideCompletedButton(),
      ],
      flexibleSpace: Padding(
        // Изменение левого паддинга от 16 до 60 в зависимости
        // от степени прокрутки.
        padding: EdgeInsets.only(
          left: leftPadding,
          bottom: bottomPadding,
        ),
        child: FlexibleSpaceBar(
          title: Text(
            'Мои дела',
            style: textTheme.headlineSmall,
          ),
          background: Padding(
            padding: EdgeInsets.only(
              right: 26,
              bottom: bottomPadding,
            ),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.bottomRight,
                  child: HideCompletedButton(
                    hasPadding: false,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Выполнено — ${state.completedCount}',
                    style: textTheme.bodyMedium!.copyWith(
                      color: CustomTextColors.of(context).secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          titlePadding: EdgeInsetsDirectional.only(bottom: titlePadding),
          collapseMode: CollapseMode.pin,
        ),
      ),
      expandedHeight: expandedHeight,
      pinned: true,
    );
  }
}
