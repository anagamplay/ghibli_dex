import 'package:flutter/material.dart';
import '../../data/services/favorite_movie_service.dart';
import '../../domain/entities/movie.dart';
import '../widgets/section_padding.dart';
import '../widgets/start_rating.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage(this.movie, {super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  bool isFavorited = false;

  late final List<String> directorList;
  late final List<String> producerList;

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();

    directorList = _splitMultiValue(widget.movie.director);
    producerList = _splitMultiValue(widget.movie.producer);
  }

  void _checkIfFavorited() async {
    final favorited = await FavoriteMovieService.isFavorited(widget.movie.id);
    setState(() {
      isFavorited = favorited;
    });
  }

  List<String> _splitMultiValue(String value) {
    return value.contains(',')
        ? value.split(',').map((e) => e.trim()).toList()
        : [value];
  }

  void _toggleFavorite() async {
    await FavoriteMovieService.toggleFavorite(widget.movie);

    final isNowFavorited =
        await FavoriteMovieService.isFavorited(widget.movie.id);

    setState(() => isFavorited = isNowFavorited);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isNowFavorited
              ? "Movie added to favorites!"
              : "Removed from favorites!",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(movie.movieBanner),
            const SizedBox(height: 16),
            SectionPadding(
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SectionPadding(
              vertical: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(movie.releaseDate),
                  StarRating(rtScore: movie.rtScore),
                ],
              ),
            ),
            SectionPadding(
              child: Text(
                movie.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            SectionPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Director", directorList),
                  _infoRow("Producer", producerList),
                  _infoRow("Running Time", ["${movie.runningTime} minutes"]),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(String url) {
    return Stack(
      children: [
        Image.network(
          url,
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: _toggleFavorite,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, List<String> values) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: values.length > 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: values.map((e) => Text(e)).toList(),
                  )
                : Text(values.first),
          ),
        ],
      ),
    );
  }
}
