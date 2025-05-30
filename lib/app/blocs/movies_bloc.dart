import 'package:http/http.dart' as http;

import '../core/utils/simple_bloc.dart';
import '../modules/movies/data/datasources/movie_remote_datasource_impl.dart';
import '../modules/movies/data/repositories_impl/movie_repository_impl.dart';
import '../modules/movies/domain/entities/movie.dart';
import '../modules/movies/domain/usecases/get_all_movies.dart';

class MoviesBloc extends SimpleBloc<List<Movie>> {
  final GetAllMovies _getAllMovies;

  MoviesBloc()
      : _getAllMovies = GetAllMovies(
          MovieRepositoryImpl(
            MovieRemoteDatasourceImpl(http.Client()),
          ),
        );

  Future<List<Movie>> fetchMovies() async {
    try {
      final movies = await _getAllMovies();
      add(movies);
      return movies;
    } catch (e) {
      addError(e);
      return [];
    }
  }
}
