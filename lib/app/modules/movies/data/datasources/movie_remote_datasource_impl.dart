import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';
import 'movie_remote_datasource.dart';

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final http.Client client;

  MovieRemoteDatasourceImpl(this.client);

  @override
  Future<List<MovieModel>> getAllMovies() async {
    final response = await client.get(Uri.parse('https://ghibliapi.vercel.app/films'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }
}
