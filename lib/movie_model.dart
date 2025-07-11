class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final double voteAverage;

  // Fungsi untuk membuat objek Movie secara manual.
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
  });

  // Fungsi untuk membuat objek Movie dari data JSON.
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      posterPath: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}