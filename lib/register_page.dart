import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk mengambil teks dari field Email, Password, dan Konfirmasi Password.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  // Instance dari service yang menangani logika otentikasi dengan Firebase.
  final AuthService _authService = AuthService();

  // Variabel state untuk mengelola UI.
  bool _isLoading = false; // Untuk menampilkan loading indicator.
  String _errorMessage = ''; // Untuk menampilkan pesan error jika ada.
  bool _isPasswordVisible = false; // Untuk toggle lihat/sembunyikan password.
  bool _isConfirmPasswordVisible = false; // Untuk toggle lihat/sembunyikan konfirmasi password.

  // Membersihkan controller saat widget tidak lagi digunakan untuk mencegah kebocoran memori.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Fungsi utama untuk menjalankan proses registrasi.
  void _signUp() async {
    // Sembunyikan keyboard agar tidak mengganggu notifikasi.
    FocusScope.of(context).unfocus();

    // Ambil nilai dari controller dan hapus spasi di awal/akhir.
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();
    
    // --- Validasi Sisi Klien (Pemeriksaan awal sebelum mengirim ke server) ---
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() => _errorMessage = 'Semua kolom harus diisi.');
      return; // Hentikan fungsi jika ada kolom yang kosong.
    }
    if (password != confirmPassword) {
      setState(() => _errorMessage = 'Password dan Konfirmasi Password tidak cocok.');
      return; // Hentikan fungsi jika password tidak cocok.
    }
    if (password.length < 6) {
      setState(() => _errorMessage = 'Password minimal harus 6 karakter.');
      return; // Hentikan fungsi jika password terlalu pendek.
    }
    // --- Akhir Validasi ---

    // Atur state untuk menampilkan loading dan menghapus pesan error lama.
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Panggil metode registrasi dari AuthService.
    User? user = await _authService.createUserWithEmailAndPassword(email, password);

    // Pastikan widget masih ada sebelum mengubah state lagi.
    if (!mounted) return;

    // Sembunyikan loading indicator setelah proses selesai.
    setState(() => _isLoading = false);

    // Periksa hasil registrasi.
    if (user == null) {
      // Jika user null, berarti registrasi gagal. Tampilkan pesan error.
      setState(() => _errorMessage = 'Registrasi Gagal. Email mungkin sudah terdaftar atau formatnya salah.');
    } else {
      // Jika berhasil, tampilkan notifikasi sukses (SnackBar).
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil! Silakan kembali ke halaman login.')),
      );
      // Kembali ke halaman login setelah beberapa saat untuk memberi waktu user membaca notifikasi.
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  // Fungsi yang membangun antarmuka (UI) untuk halaman registrasi.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: const Color(0xFFA259FF),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Join MoFi Today',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFA259FF)),
            ),
            const SizedBox(height: 20),
            
            // Input field untuk Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),

            // Input field untuk Password
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, // Sembunyikan teks jika _isPasswordVisible false
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input field untuk Konfirmasi Password
            TextField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible, // Sembunyikan teks
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                  icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                ),
              ),
            ),
            
            // Menampilkan pesan error jika ada.
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(_errorMessage, style: const TextStyle(color: Colors.red, fontSize: 14)),
              ),
            const SizedBox(height: 30),
            
            // Tombol Register
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                // Tombol dinonaktifkan saat sedang loading.
                onPressed: _isLoading ? null : _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                // Tampilkan loading indicator atau teks 'Register'.
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Register', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            
            // Tombol untuk kembali ke halaman Login.
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}