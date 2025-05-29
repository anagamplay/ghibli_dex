import 'package:flutter/material.dart';
import '../../../../core/utils/nav.dart';
import '../../domain/entities/movie.dart';
import '../pages/movie_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => push(context, MoviePage(movie)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.image,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
