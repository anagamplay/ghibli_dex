import 'package:http/http.dart' as http;

import '../../../../core/utils/simple_bloc.dart';
import '../../data/datasources/movie_remote_datasource_impl.dart';
import '../../data/repositories_impl/movie_repository_impl.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_all_movies.dart';

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
