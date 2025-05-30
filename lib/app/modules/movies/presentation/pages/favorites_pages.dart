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

class _FavoritesPageState extends State<FavoritesPage> with AutomaticKeepAliveClientMixin<FavoritesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    FavoriteMovieService.getFavorites().then((movies) {
      FavoriteMovieService.favoritesNotifier.value = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ValueListenableBuilder<List<Movie>>(
      valueListenable: FavoriteMovieService.favoritesNotifier,
      builder: (context, favorites, _) {
        if (favorites.isEmpty) {
          return const Center(child: Text("Nenhum filme favoritado."));
        }

        return MovieListComponent(
          movies: favorites,
          scrollController: widget.scrollController,
        );
      },
    );
  }
}
