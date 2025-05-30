import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.description,
    required super.image,
    required super.releaseDate,
    required super.movieBanner,
    required super.director,
    required super.producer,
    required super.runningTime,
    required super.rtScore,
    required super.originalTitleRomanised,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      releaseDate: json['release_date'],
      movieBanner: json['movie_banner'],
      director: json['director'],
      producer: json['producer'],
      runningTime: json['running_time'],
      rtScore: json['rt_score'],
      originalTitleRomanised: json['original_title_romanised'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'release_date': releaseDate,
      'movie_banner': movieBanner,
      'director': director,
      'producer': producer,
      'running_time': runningTime,
      'rt_score': rtScore,
      'original_title_romanised': originalTitleRomanised,
    };
  }

  static MovieModel fromEntity(Movie movie) {
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
}
