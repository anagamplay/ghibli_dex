import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import 'movie_list_card.dart';

class MovieListComponent extends StatelessWidget {
  final List<Movie> movies;
  final ScrollController scrollController;

  const MovieListComponent({
    required this.movies,
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieListCard(movie: movies[index]);
      },
    );
  }
}
