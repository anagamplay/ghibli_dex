import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghibli_dex/app/modules/movies/presentation/blocs/movies_bloc.dart';
import '../../domain/entities/movie.dart';
import '../widgets/movie_list_component.dart';

class MovieListPage extends StatefulWidget {
  final ScrollController scrollController;

  const MovieListPage({required this.scrollController, super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final _bloc = MoviesBloc();
  final PageController _pageController = PageController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _bloc.fetchMovies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('[ERRO] Não foi possível buscar os filmes');
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final movies = snapshot.data!;

        return MovieListComponent(
          movies: movies,
          scrollController: widget.scrollController,
        );
      },
    );
  }
}
