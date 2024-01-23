import 'package:flutter/material.dart';

class MyBadge extends StatelessWidget {
  final String text;
  final bool? isActive;
  final Function? onClick;
  const MyBadge({
    super.key,
    required this.text,
    this.isActive = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isActive != null && isActive == true
            ? Theme.of(context).colorScheme.secondary
            : null,
      ),
      child: GestureDetector(
        onTap: () {
          if (onClick != null) {
            onClick!();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isActive != null && isActive == true
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
      ),
    );
  }
}
