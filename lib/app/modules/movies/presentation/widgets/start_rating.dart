import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final String rtScore;

  const StarRating({required this.rtScore, super.key});

  @override
  Widget build(BuildContext context) {
    final double score = double.tryParse(rtScore) ?? 0;
    final double stars = (score / 100) * 5;

    return Row(
      children: List.generate(5, (index) {
        if (index < stars.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index < stars) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }
}
