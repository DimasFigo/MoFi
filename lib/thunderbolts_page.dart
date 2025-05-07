// mengimport semua package yang digunakan
import 'package:flutter/material.dart';

// ini adalah membuat halaman dengan statefullwidget interaktif
class ThunderboltsPage extends StatefulWidget {
  const ThunderboltsPage({super.key});

  @override
  State<ThunderboltsPage> createState() => _ThunderboltsPageState();
}

class _ThunderboltsPageState extends State<ThunderboltsPage> {
  // ini untuk deklarasi nilai isLiked adalah false default
  bool isLiked = false;

  // ini untuk deklarasi nilai Rating default
  double userRating = 3.0;

  @override
  Widget build(BuildContext context) {
    // scaffold berfungsi sebagai rangka utama layout halaman
    return Scaffold(
      // ini adalah judul halaman 
      appBar: AppBar(
        title: const Text('Thunderbolts Details'),
        backgroundColor: const Color(0xFFA259FF),
      ),
      // ini adalah konten nya
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // ini untuk menampilkan gambar movie nya
          children: [
            Image.asset(
              'assets/images/thunderbolts.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),

            // ini untuk menampilkaan judul movie
            const Text(
              'Thunderbolts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // ini untuk menampilkan genre sesuai dengan movie
            const Text(
              'Genre: Action, Sci-Fi\nDuration: 2h 10min\nRelease: 2025',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // ini untuk menampilkan sinopsis singkat dari movie 
            const Text(
              'Synopsis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // ini adalah isi dari sinposis nya
            const Text(
              'Thunderbolts adalah film superhero yang menceritakan sekelompok antihero '
              'yang dikumpulkan oleh pemerintah untuk menjalankan misi-misi berbahaya. '
              'Film ini penuh aksi, konflik karakter, dan efek visual spektakuler.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // ini adalah button like 
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  // ini adalah ketika like ditekan maka nilai like akan berubah nilai type nya boolean
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    // ini untuk menampilkan pop up ketika like dan unlike
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isLiked
                            ? 'Kamu menyukai Thunderbolts!'
                            : 'Like dibatalkan.'),
                      ),
                    );
                  },
                ),
                Text(isLiked ? 'You liked this movie' : 'Like this movie?'),
              ],
            ),
            const SizedBox(height: 20),

            // ini adalah menu wathc trailer 
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4D8),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Watch Trailer'),
              // ini adalah ketika menu watch trailer ditekan maka akan keluar pesan pop up
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Memutar trailer... '),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // ini adalah menu rating yang dimana rating defalut 3.0
            const Text(
              'Your Rating:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: userRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: userRating.toString(),
              // ini untuk ketika rating diubah maka nilai juga akan berubah
              onChanged: (value) {
                setState(() {
                  userRating = value;
                });
              },
            ),
            Text('Rating kamu: ${userRating.toStringAsFixed(1)} / 5'),
          ],
        ),
      ),

      // ini adlah navigasi bottom 
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFA259FF),
        unselectedItemColor: Colors.grey,
        items: const [
          // ini untuk menu home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // ini untuk menu favorite
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          // ini untuk menu profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // ini untuk ketika navigasi ditekan maka akan keluar pesan pop up
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigasi ditekan')),
          );
        },
      ),
    );
  }
}
