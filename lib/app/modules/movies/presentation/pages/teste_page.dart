import 'package:flutter/material.dart';

class TestePage extends StatelessWidget {
  final ScrollController scrollController;

  const TestePage({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: [
        Center(
          child: Text('Filmes!'),
        ),
      ],
    );
  }
}
