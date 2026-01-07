import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../utils/api_keys.dart';

class TMDBService {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = ApiKeys.tmdbApiKey;

  Future<List<Movie>> searchMoviesByMood({
    required String genre,
    required bool needsUplifting,
    int page = 1,
  }) async {
    try {
      final genreId = _getGenreId(genre, needsUplifting);

      // Sadece yüksek puanlı ve popüler filmleri getir
      final url = Uri.parse(
        '$baseUrl/discover/movie?'
        'api_key=$apiKey'
        '&with_genres=$genreId'
        '&sort_by=popularity.desc'
        '&vote_average.gte=6.5'
        '&vote_count.gte=500'
        '&page=$page'
        '&language=tr-TR',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching movies: $e');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final url = Uri.parse(
        '$baseUrl/movie/$movieId?api_key=$apiKey&language=tr-TR',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting movie details: $e');
    }
  }

  Future<Movie> getRandomMovieByMood({
    required String genre,
    required bool needsUplifting,
  }) async {
    final movies = await searchMoviesByMood(
      genre: genre,
      needsUplifting: needsUplifting,
    );

    if (movies.isEmpty) {
      throw Exception('No movies found for the given mood');
    }

    // Return a random movie from the top results
    movies.shuffle();
    return movies.first;
  }

  int _getGenreId(String genre, bool needsUplifting) {
    final g = genre.toLowerCase();

    if (needsUplifting && (g.isEmpty || g == 'drama')) {
      return 35;
    }

    switch (g) {
      case 'comedy':
        return 35;
      case 'romance':
        return 10749;
      case 'thriller':
        return 53;
      case 'horror':
        return 27;
      case 'action':
        return 28;
      case 'adventure':
        return 12;
      case 'family':
        return 10751;
      case 'animation':
        return 16;
      case 'fantasy':
        return 14;
      case 'sci-fi':
      case 'science fiction':
        return 878;
      case 'drama':
      default:
        return 18;
    }
  }
}
