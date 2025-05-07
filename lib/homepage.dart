// mengimport semua package dan file halaman yang digunakan
import 'package:flutter/material.dart';
import 'thunderbolts_page.dart'; 
import 'havoc_page.dart';        
import 'sinners_page.dart';       

// ini adalah membuat halaman dengan statelesswidget tidak interaktif
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // list movie yang akan ditampilkan 
  final List<Map<String, String>> movies = const [
    {
      'title': 'Thunderbolts',
      'image': 'assets/images/thunderbolts.jpg',
    },
    {
      'title': 'Havoc',
      'image': 'assets/images/havoc.jpeg',
    },
    {
      'title': 'Sinners',
      'image': 'assets/images/sinners.jpg',
    },
  ];

  // ini adalah list genre yang akan ditampilkan
  final List<String> genres = const [
    'Action',
    'Adventure',
    'Drama',
    'Comedy',
    'Sci-Fi',
    'Horror',
  ];

  @override
  Widget build(BuildContext context) {
    // scaffold berfungsi sebagai rangka utama layout halaman
    return Scaffold( 
      backgroundColor: Colors.white,
      // terdapat AppBar yang berfungsi menampilkah header diatas halaman
      appBar: AppBar(
        // ini adalah judul yang halaman homepage
        title: const Text("MoFi - Home"),
        backgroundColor: const Color(0xFFA259FF),
        centerTitle: true,
        elevation: 4,
      ),
      // Drawer berfungsi sebagai menu navigasi sidebar 
      drawer: Drawer(
        backgroundColor: const Color(0xFFF5F5F5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // header drawer
            Container(
              color: const Color(0xFFA259FF),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.account_circle, size: 50, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'Welcome, User!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            // ini adalah menu item setting
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              // ini adalah menu ketika dia meng klick menu setting maka akan keluar text nya pop up
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigasi ke Pengaturan')),
                );
              },
            ),
            // ini  adalah garis pemisah
            const Divider(),
            // ini adalah menu logout 
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              // ini adalah menu ketika dia meng klick menu logout maka akan keluar text pop up
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil logout')),
                );
              },
            ),
          ],
        ),
      ),

      // ini adalah body halaman utama 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Ini adalah konten trending
            const Text(
              '🔥 Trending Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 12),

            // ini adalah list movie
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      // seleksi if ini digunakan untuk ketika meng klick movie yang dipilih maka akan diarahkan 
                      // page sesuai dengan nama movie nya
                      if (movie['title'] == 'Thunderbolts') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ThunderboltsPage()),
                        );
                      } else if (movie['title'] == 'Havoc') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HavocPage()),
                        );
                      } else if (movie['title'] == 'Sinners') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SinnersPage()),
                        );
                      }
                    },
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          Image.asset(
                            movie['image']!,
                            width: 120,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie['title']!,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            // ini adalah konten genre
            const Text(
              '🎬 Browse by Genre',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 12),

            // ini digunakan untuk genre bisa ditekan
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: genres.map((genre) {
                return ActionChip(
                  backgroundColor: const Color(0xFF00B4D8),
                  label: Text(
                    genre,
                    style: const TextStyle(color: Colors.white),
                  ),
                  // ini adalah ketika genre ditekan maka akan menampilkan pesan pop up
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kamu memilih genre: $genre'),
                        backgroundColor: const Color(0xFFA259FF),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // ini adalah konten All Movies
            const Text(
              '📺 All Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 12),

            // ini adalah list daftar film
            Column(
              children: movies.map((movie) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  color: const Color(0xFFF0F0F0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Image.asset(
                      movie['image']!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      movie['title']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.play_circle_fill,
                      color: Color(0xFF00B4D8),
                      size: 30,
                    ),
                    onTap: () { 
                      // seleksi if ini digunakan untuk ketika meng klick movie yang dipilih maka akan diarahkan 
                      // page sesuai dengan nama movie nya
                      if (movie['title'] == 'Thunderbolts') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ThunderboltsPage()),
                        );
                      } else if (movie['title'] == 'Havoc') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HavocPage()),
                        );
                      } else if (movie['title'] == 'Sinners') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SinnersPage()),
                        );
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),

      // ini adalah menu navigation bar di bawah 
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFA259FF),
        unselectedItemColor: Colors.grey,
        items: const [
          // ini adalah menu home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // ini adalah menu favorites
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          // ini adalah menu profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // ini adalah ketika navigasi ditekan akan keluar pop up
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigasi ditekan')),
          );
        },
      ),
    );
  }
}
