import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';
import '../mappers/movie_mapper.dart';

class FavoriteMovieService {
  static const _key = 'favorited_movies';
  static final ValueNotifier<List<Movie>> favoritesNotifier = ValueNotifier([]);

  static Future<void> _updatePrefs(List<Movie> list) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> jsonList = list
        .map((movie) => jsonEncode(MovieMapper.toModel(movie).toJson()))
        .toList();

    await prefs.setStringList(_key, jsonList);

    favoritesNotifier.value = List.from(list);
  }

  static Future<List<Movie>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_key);

    if (jsonList == null) return [];

    List<Movie> movies = [];

    for (var item in jsonList) {
      try {
        final map = jsonDecode(item);
        final model = MovieModel.fromJson(map);
        final movie = MovieMapper.toEntity(model);
        movies.add(movie);
      } catch (e) {
        debugPrint("Erro ao converter favorito: $e");
      }
    }

    return movies;
  }

  static Future<void> toggleFavorite(Movie movie) async {
    List<Movie> list = await getFavorites();
    final exists = list.any((m) => m.id == movie.id);

    if (exists) {
      list.removeWhere((m) => m.id == movie.id);
    } else {
      list.add(movie);
    }

    await _updatePrefs(list);
  }

  static Future<bool> isFavorited(String id) async {
    List<Movie> list = await getFavorites();
    return list.any((m) => m.id == id);
  }

  static Future<bool> hasFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key);
    return jsonList != null && jsonList.isNotEmpty;
  }
}
