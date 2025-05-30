import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';

class MovieMapper {
  static MovieModel toModel(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      description: movie.description,
      image: movie.image,
      releaseDate: movie.releaseDate,
      movieBanner: movie.movieBanner,
      director: movie.director,
      producer: movie.producer,
      runningTime: movie.runningTime,
      rtScore: movie.rtScore,
      originalTitleRomanised: movie.originalTitleRomanised,
    );
  }

  static Movie toEntity(MovieModel model) {
    return Movie(
      id: model.id,
      title: model.title,
      description: model.description,
      image: model.image,
      releaseDate: model.releaseDate,
      movieBanner: model.movieBanner,
      director: model.director,
      producer: model.producer,
      runningTime: model.runningTime,
      rtScore: model.rtScore,
      originalTitleRomanised: model.originalTitleRomanised,
    );
  }
}
