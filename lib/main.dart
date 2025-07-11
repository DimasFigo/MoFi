import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_service.dart';
import 'auth_wrapper.dart';
import 'firebase_options.dart';
import 'register_page.dart'; 

// Fungsi utama yang pertama kali dijalankan saat aplikasi dibuka.
void main() async {
  // Memastikan semua komponen Flutter siap sebelum menjalankan kode async.
  WidgetsFlutterBinding.ensureInitialized();

  // Memuat variabel lingkungan dari file .env.
  await dotenv.load(fileName: ".env");

  // Menginisialisasi koneksi ke Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Menjalankan aplikasi utama.
  runApp(const MovieGoApp());
}

// Widget root dari aplikasi.
class MovieGoApp extends StatelessWidget {
  const MovieGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoFi',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug.
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        // Tema default untuk semua input field di aplikasi.
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF0F0F0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      // AuthWrapper akan menentukan halaman mana yang ditampilkan (Login atau Home).
      home: const AuthWrapper(),
    );
  }
}

// Widget untuk halaman login.
class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  // Controller untuk field email dan password.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // State untuk UI.
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isPasswordVisible = false;

  // Membersihkan controller untuk mencegah memory leak.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk menangani proses login pengguna.
  void _signIn() async {
    FocusScope.of(context).unfocus(); // Menutup keyboard.
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Validasi input.
    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Email dan Password tidak boleh kosong.');
      return;
    }

    // Memulai proses loading.
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Memanggil service untuk login.
    User? user = await _authService.signInWithEmailAndPassword(email, password);

    if (!mounted) return;

    // Menghentikan proses loading.
    setState(() => _isLoading = false);

    // Menampilkan pesan error jika login gagal.
    if (user == null) {
      setState(() => _errorMessage = 'Login Gagal. Periksa kembali email dan password Anda.');
    }
    // Navigasi ke halaman utama ditangani secara otomatis oleh AuthWrapper.
  }

  // Fungsi untuk membangun UI halaman login.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to MoFi',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFA259FF)),
            ),
            const SizedBox(height: 20),
            // Menampilkan logo aplikasi.
            SizedBox(
              width: 200, height: 150,
              child: Image.asset('assets/images/mofi.png'),
            ),
            const SizedBox(height: 30),

            // Field input untuk email.
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 20),

            // Field input untuk password.
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
            ),

            // Widget untuk menampilkan pesan error.
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Text(_errorMessage, style: const TextStyle(color: Colors.red, fontSize: 14), textAlign: TextAlign.center),
              ),
            const SizedBox(height: 20),
            
            // Tombol Login.
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            
            // Tombol untuk navigasi ke halaman registrasi.
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text(
                'New to MoFi? Create Account',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}