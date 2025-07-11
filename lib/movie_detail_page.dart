import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'api_service.dart';
import 'movie_model.dart';

class MovieDetailPage extends StatefulWidget {
  // Menerima objek Movie lengkap untuk menampilkan data awal sebelum detail dimuat.
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final ApiService _apiService = ApiService();
  // Future untuk menampung hasil pemanggilan API detail film.
  late Future<Map<String, dynamic>> _movieDetailsFuture;

  // State untuk menyimpan status 'like' dari pengguna.
  bool _isLiked = false;
  // State untuk menyimpan rating yang diberikan oleh pengguna.
  double _userRating = 0.0;

  @override
  void initState() {
    super.initState();
    // Memanggil API untuk mendapatkan detail film saat halaman pertama kali dibuka.
    // Menggunakan ID dari movie yang diterima melalui widget.
    _movieDetailsFuture = _apiService.getMovieDetails(widget.movie.id);
  }

  /// Fungsi untuk mengubah durasi dari menit menjadi format 'Xh Ymin'.
  /// Contoh: 130 menit akan menjadi '2h 10min'.
  String _formatDuration(int minutes) {
    final int hours = minutes ~/ 60;
    final int remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }

  /// Fungsi untuk membuka trailer film di YouTube.
  /// Menggunakan package url_launcher untuk membuka URL.
  void _launchTrailer(String? youtubeKey) async {
    if (youtubeKey != null) {
      // Membuat URL YouTube dari key yang didapat.
      final Uri url = Uri.parse('https://www.youtube.com/watch?v=$youtubeKey');
      if (!await launchUrl(url)) {
        // Jika gagal membuka URL, tampilkan pesan error.
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak bisa membuka trailer: $url')),
        );
      }
    } else {
      // Jika youtubeKey null, berarti trailer tidak tersedia.
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Trailer tidak tersedia.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FutureBuilder digunakan untuk membangun UI berdasarkan status Future.
      // Ini adalah cara yang efisien untuk menangani data yang datang dari API.
      body: FutureBuilder<Map<String, dynamic>>(
        future: _movieDetailsFuture,
        builder: (context, snapshot) {
          // Saat data masih dimuat, tampilkan UI loading.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingUI();
          }
          // Jika terjadi error saat memuat data, tampilkan UI error.
          if (snapshot.hasError) {
            return _buildErrorUI(snapshot.error);
          }
          // Jika data berhasil dimuat, tampilkan konten utama.
          if (snapshot.hasData) {
            return _buildContentUI(snapshot.data!);
          }
          // State default jika tidak ada data (seharusnya tidak terjadi).
          return Container();
        },
      ),
    );
  }

  /// Widget yang ditampilkan saat data sedang dimuat.
  /// Menampilkan judul film dari data awal dan sebuah CircularProgressIndicator.
  Widget _buildLoadingUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.movie.title} Details'),
        backgroundColor: const Color(0xFFA259FF),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  /// Widget yang ditampilkan jika terjadi kesalahan saat memuat data.
  Widget _buildErrorUI(Object? error) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.movie.title} Details'),
        backgroundColor: const Color(0xFFA259FF),
      ),
      body: Center(child: Text('Gagal memuat data: $error')),
    );
  }

  /// Widget utama yang membangun seluruh UI konten halaman detail.
  /// Dipanggil setelah data dari API berhasil diterima.
  Widget _buildContentUI(Map<String, dynamic> details) {
    // Ekstrak data yang diperlukan dari objek 'details' (hasil API) dan 'widget.movie' (data awal).
    final posterUrl =
        'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}';
    final genres = (details['genres'] as List).map((g) => g['name']).join(', ');
    final duration = _formatDuration(details['runtime'] ?? 0);
    final releaseDate = details['release_date'] ?? 'N/A';
    final synopsis = widget.movie.overview;
    final youtubeKey = details['youtubeKey'];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.movie.title} Details'),
        backgroundColor: const Color(0xFFA259FF),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Poster Film
            Image.network(
              posterUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              // Menampilkan loading indicator saat gambar sedang diunduh.
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 250,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              // Menampilkan icon error jika gambar gagal dimuat.
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[200],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, color: Colors.grey, size: 80),
                      SizedBox(height: 8),
                      Text(
                        'Gagal memuat gambar',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Bagian Detail Teks (Judul, Genre, Durasi, dll)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Genre: $genres',
                    style: TextStyle(color: Colors.grey[700], fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Duration: $duration',
                    style: TextStyle(color: Colors.grey[700], fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Release: $releaseDate',
                    style: TextStyle(color: Colors.grey[700], fontSize: 15),
                  ),
                  const SizedBox(height: 24),

                  // Bagian Sinopsis
                  const Text(
                    'Synopsis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    synopsis.isEmpty ? 'No synopsis available.' : synopsis,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bagian Tombol 'Like'
                  InkWell(
                    onTap: () => setState(() => _isLiked = !_isLiked),
                    child: Row(
                      children: [
                        Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Like this movie?',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bagian Tombol 'Watch Trailer'
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchTrailer(youtubeKey),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Watch Trailer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B4D8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bagian Rating Pengguna
                  const Text(
                    'Your Rating:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: _userRating,
                    min: 0.0,
                    max: 5.0,
                    divisions: 10,
                    label: _userRating.toStringAsFixed(1),
                    activeColor: const Color(0xFFA259FF),
                    onChanged: (newRating) =>
                        setState(() => _userRating = newRating),
                  ),
                  Center(
                    child: Text(
                      'Rating kamu: ${_userRating.toStringAsFixed(1)} / 5',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}