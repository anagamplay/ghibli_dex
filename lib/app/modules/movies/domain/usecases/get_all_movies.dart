import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetAllMovies {
  final MovieRepository repository;

  GetAllMovies(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getAllMovies();
  }
}