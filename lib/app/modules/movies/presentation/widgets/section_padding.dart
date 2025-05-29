import 'package:flutter/material.dart';

class SectionPadding extends StatelessWidget {
  final Widget child;
  final double horizontal;
  final double vertical;

  const SectionPadding({
    required this.child,
    this.horizontal = 16,
    this.vertical = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: child,
    );
  }
}
