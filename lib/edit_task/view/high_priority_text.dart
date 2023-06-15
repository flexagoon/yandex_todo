import 'package:flutter/material.dart';
import 'package:yandex_todo/app/view/custom_colors.dart';

class HighPriorityText extends StatelessWidget {
  const HighPriorityText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: CustomColors.of(context).red,
            ),
        children: const [
          TextSpan(
            text: '!!',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          WidgetSpan(
            child: SizedBox(
              width: 2,
            ),
          ),
          TextSpan(text: 'Важная'),
        ],
      ),
    );
  }
}
