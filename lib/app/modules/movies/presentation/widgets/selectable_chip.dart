import 'package:flutter/material.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;

  const SelectableChip({
    super.key,
    required this.label,
    this.selected = false,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = !enabled
        ? Colors.grey.shade400
        : selected
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade200;

    final Color textColor = !enabled
        ? Colors.grey.shade700
        : selected
            ? Colors.white
            : Colors.black;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Chip(
        label: Text(label, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
