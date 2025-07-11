import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_model.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? 'API_KEY_NOT_FOUND';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  // Fungsi ini sekarang mengembalikan List<Movie>
  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      // Menggunakan factory constructor .fromJson untuk mengubah setiap item map menjadi objek Movie
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Gagal memuat film populer');
    }
  }

  // Fungsi getMovieDetails tetap sama karena kita butuh data yang lebih kaya darinya
  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey'));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat detail film');
    }
    final Map<String, dynamic> movieDetails = json.decode(response.body);

    final videosResponse = await http.get(Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey'));
    if (videosResponse.statusCode == 200) {
      final videosData = json.decode(videosResponse.body)['results'] as List;
      final officialTrailer = videosData.firstWhere(
        (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer',
        orElse: () => null,
      );
      movieDetails['youtubeKey'] = officialTrailer?['key'];
    }
    return movieDetails;
  }
}