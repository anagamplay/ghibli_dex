import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.description,
    required super.image,
    required super.releaseDate,
    required super.movieBanner,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      releaseDate: json['release_date'],
      movieBanner: json['movie_banner'],
    );
  }
}
