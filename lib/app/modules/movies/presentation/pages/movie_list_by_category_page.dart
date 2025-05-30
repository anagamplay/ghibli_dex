import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../blocs/movies_bloc.dart';
import '../../../../core/utils/nav.dart';
import '../../domain/entities/movie.dart';
import '../widgets/movie_card.dart';
import 'movie_page.dart';

class MovieListByCategoryPage extends StatefulWidget {
  final ScrollController scrollController;

  const MovieListByCategoryPage({required this.scrollController, super.key});

  @override
  State<MovieListByCategoryPage> createState() => _MovieListByCategoryPageState();
}

class _MovieListByCategoryPageState extends State<MovieListByCategoryPage> {
  final _bloc = MoviesBloc();
  final PageController _pageController = PageController();

  Timer? _timer;
  int _currentPage = 0;

  final List<Movie> _shuffledMovies = [];

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
        if (snapshot.hasError) return const _ErrorWidget();
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final movies = snapshot.data!;
        if (movies.isEmpty) return const _EmptyWidget();

        final sortedMovies = _sortMoviesByReleaseYear(movies);

        _shuffledMovies.clear();
        _shuffledMovies.addAll(sortedMovies);
        _shuffledMovies.shuffle();

        final latestReleases = sortedMovies.take(7).toList();
        final olderMovies = sortedMovies.skip(7).toList();
        final moviesByDecade = _groupMoviesByDecade(olderMovies);

        _startAutoScroll();

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(10),
            children: [
              _buildCarousel(_shuffledMovies),
              const SizedBox(height: 20),
              const Text(
                "Latest Releases",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildHorizontalMovieList(latestReleases),
              const SizedBox(height: 20),
              ...moviesByDecade.entries.map((entry) {
                return _buildDecadeSection(entry.key, entry.value);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCarousel(List<Movie> movies) {
    if (movies.isEmpty) {
      return const SizedBox(height: 300);
    }

    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => push(context, MoviePage(movies[index])),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movies[index].image,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 350,
                ),
              ),
            ),
          );
        },
        onPageChanged: (index) {
          _currentPage = index;
        },
      ),
    );
  }

  void _startAutoScroll() {
    _timer?.cancel();

    if (_shuffledMovies.isEmpty) return;

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_pageController.hasClients) return;

      if (_currentPage >= _shuffledMovies.length - 1) {
        setState(() {
          _shuffledMovies.shuffle();
        });
      } else {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget _buildHorizontalMovieList(List<Movie> movies) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return MovieCard(movie: movies[index]);
        },
      ),
    );
  }

  Widget _buildDecadeSection(String decade, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          decade,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildHorizontalMovieList(movies),
        const SizedBox(height: 20),
      ],
    );
  }

  List<Movie> _sortMoviesByReleaseYear(List<Movie> movies) {
    final copy = List<Movie>.from(movies);
    copy.sort((a, b) {
      final yearA = int.tryParse(a.releaseDate) ?? 0;
      final yearB = int.tryParse(b.releaseDate) ?? 0;
      return yearB.compareTo(yearA);
    });
    return copy;
  }

  Map<String, List<Movie>> _groupMoviesByDecade(List<Movie> movies) {
    final Map<String, List<Movie>> grouped = {};

    for (final movie in movies) {
      final year = int.tryParse(movie.releaseDate);
      if (year == null) continue;

      final decadeStart = (year ~/ 10) * 10;
      final decadeLabel = '${decadeStart}s';

      grouped.putIfAbsent(decadeLabel, () => []).add(movie);
    }

    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        final decadeA = int.parse(a.replaceAll('s', ''));
        final decadeB = int.parse(b.replaceAll('s', ''));
        return decadeB.compareTo(decadeA);
      });

    return {
      for (var key in sortedKeys) key: grouped[key]!,
    };
  }

  Future<void> _onRefresh() => _bloc.fetchMovies();
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('[ERRO] Não foi possível buscar os filmes'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context
                .findAncestorStateOfType<_MovieListByCategoryPageState>()
                ?._onRefresh(),
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context
              .findAncestorStateOfType<_MovieListByCategoryPageState>()
              ?._onRefresh() ??
          Future.value(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 200),
          Center(
            child: Text(
              'Nenhum filme encontrado.\nPuxe para atualizar.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
