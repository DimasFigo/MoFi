import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'api_service.dart';
import 'auth_service.dart'; 
import 'movie_model.dart'; 
import 'movie_detail_page.dart';

// Widget utama untuk halaman beranda (Home).
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State untuk menyimpan data dari API.
  late Future<List<Movie>> _popularMovies;
  final ApiService _apiService = ApiService();
  
  // State untuk Bottom Navigation Bar.
  int _selectedIndex = 0;

  // State untuk data otentikasi pengguna.
  final AuthService _authService = AuthService();
  User? _user;

  // Daftar genre film (data statis).
  final List<String> genres = const [
    'Action', 'Adventure', 'Drama', 'Comedy', 'Sci-Fi', 'Horror',
  ];

  // Fungsi yang dijalankan pertama kali saat halaman dimuat.
  @override
  void initState() {
    super.initState();
    // Mengambil data film populer dari API.
    _popularMovies = _apiService.getPopularMovies();
    // Mengambil informasi pengguna yang sedang login.
    _user = FirebaseAuth.instance.currentUser;
  }

  // Fungsi yang menangani event tap pada Bottom Navigation Bar.
  void _onNavBarTapped(int index) {
    setState(() => _selectedIndex = index);
    // Logika untuk navigasi lain bisa ditambahkan di sini.
  }

  // Fungsi utama yang membangun seluruh UI halaman.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MoFi - Home", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFA259FF),
        elevation: 0,
      ),
      // Menambahkan drawer (menu samping) ke Scaffold.
      drawer: _buildAppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGenreSection(),
              const SizedBox(height: 24),
              _buildAllMoviesSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFA259FF),
        onTap: _onNavBarTapped,
      ),
    );
  }

  // Fungsi untuk membangun widget Drawer (menu samping).
  Widget _buildAppDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Header pada drawer yang menampilkan info pengguna.
          UserAccountsDrawerHeader(
            accountName: Text(
              _user?.displayName ?? 'Guest User', // Tampilkan nama pengguna.
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(_user?.email ?? 'no-email@example.com'), // Tampilkan email.
            currentAccountPicture: CircleAvatar(
              // Tampilkan foto profil dari URL jika ada.
              backgroundImage: _user?.photoURL != null 
                  ? NetworkImage(_user!.photoURL!) 
                  : null,
              // Jika tidak ada foto, tampilkan huruf pertama dari email.
              child: _user?.photoURL == null 
                  ? Text(_user?.email?.substring(0, 1).toUpperCase() ?? 'G') 
                  : null,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFA259FF),
            ),
          ),
          // Menu item di dalam drawer.
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            onTap: () => Navigator.pop(context), // Tutup drawer.
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Favorites'),
            onTap: () => Navigator.pop(context), // Tutup drawer.
          ),
          const Divider(), // Garis pemisah.
          // Menu item untuk logout.
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              Navigator.pop(context); // Tutup drawer terlebih dahulu.
              await _authService.signOut();
              // AuthWrapper akan otomatis mengarahkan ke halaman login.
            },
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun bagian genre.
  Widget _buildGenreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🎬 Browse by Genre', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: genres.map((genre) => ActionChip(
            label: Text(genre),
            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            backgroundColor: const Color(0xFF00B4D8),
            onPressed: () {}, // Aksi saat genre ditekan.
          )).toList(),
        ),
      ],
    );
  }

  // Fungsi untuk membangun bagian daftar semua film.
  Widget _buildAllMoviesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('📺 All Movies', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        // FutureBuilder untuk menampilkan data film yang diambil dari API.
        FutureBuilder<List<Movie>>(
          future: _popularMovies,
          builder: (context, snapshot) {
            // Tampilkan loading indicator saat data sedang dimuat.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } 
            // Tampilkan pesan error jika terjadi kesalahan.
            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } 
            // Tampilkan pesan jika tidak ada data.
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada film yang ditemukan.'));
            }
            // Jika data berhasil dimuat, bangun daftar film.
            final movies = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true, // Agar ListView menyesuaikan ukurannya dengan konten.
              physics: const NeverScrollableScrollPhysics(), // Menonaktifkan scroll di dalam ListView.
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _buildMovieListItem(movie); // Bangun item untuk setiap film.
              },
            );
          },
        ),
      ],
    );
  }

  // Fungsi untuk membangun satu item dalam daftar film.
  Widget _buildMovieListItem(Movie movie) {
    final imageUrl = 'https://image.tmdb.org/t/p/w200${movie.posterPath}';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        // Aksi saat item film ditekan (navigasi ke halaman detail).
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movie)),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(imageUrl, width: 70, height: 100, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1), // Format rating.
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.play_circle_fill, color: Color(0xFF00B4D8), size: 40),
            ],
          ),
        ),
      ),
    );
  }
}