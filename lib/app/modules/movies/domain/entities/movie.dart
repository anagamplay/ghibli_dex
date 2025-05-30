class Movie {
  final String id;
  final String title;
  final String originalTitleRomanised;
  final String description;
  final String image;
  final String releaseDate;
  final String movieBanner;
  final String director;
  final String producer;
  final String runningTime;
  final String rtScore;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.releaseDate,
    required this.movieBanner,
    required this.director,
    required this.producer,
    required this.runningTime,
    required this.rtScore,
    required this.originalTitleRomanised,
  });
}
