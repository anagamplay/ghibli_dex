import 'package:flutter/material.dart';
import 'package:ghibli_dex/app/modules/movies/data/services/favorite_movie_service.dart';
import 'package:ghibli_dex/app/modules/movies/domain/entities/movie.dart';

import '../widgets/movie_list_component.dart';

class FavoritesPage extends StatefulWidget {
  final ScrollController scrollController;

  const FavoritesPage({required this.scrollController, super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<List<Movie>>? future;

  @override
  void initState() {
    super.initState();
    future = FavoriteMovieService.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
              child: Text("Erro ao carregar favoritos ${snapshot.error}"));
        }

        List<Movie> movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return const Center(child: Text("Nenhum filme favoritado."));
        }

        return MovieListComponent(
          movies: movies,
          scrollController: widget.scrollController,
        );
      },
    );
  }
}
