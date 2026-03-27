import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({
    super.key,
    required this.selected,
    required this.onTabChanged,
  });

  final int selected;
  final void Function(int index) onTabChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final iconItems = [
      (Icons.home, 'Home'),
      (Icons.chat, 'Chat'),
      (Icons.history, 'History'),
    ];

    return Container(
      height: kBottomNavigationBarHeight + 15,
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 8,
            color: scheme.shadow.withOpacity(0.1),
          ),
        ],
        border: Border(
          top: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      child: Row(
        children: List.generate(iconItems.length, (index) {
          final nav = iconItems[index];
          final active = selected == index;

          final itemColor = active ? scheme.primary : scheme.onSurfaceVariant;

          return Expanded(
            child: InkWell(
              onTap: () => onTabChanged(index),
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    nav.$1,
                    size: 22,
                    color: itemColor,
                  ),
                  const Gap(4),
                  Text(
                    nav.$2,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: itemColor,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
