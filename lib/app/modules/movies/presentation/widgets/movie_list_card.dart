import 'package:flutter/material.dart';
import '../../../../core/utils/nav.dart';
import '../../domain/entities/movie.dart';
import '../pages/movie_page.dart';

class MovieListCard extends StatelessWidget {
  final Movie movie;

  const MovieListCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => push(context, MoviePage(movie)),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                movie.image,
                height: 120,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.originalTitleRomanised,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Released date: ${movie.releaseDate}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Score: ${movie.rtScore}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
