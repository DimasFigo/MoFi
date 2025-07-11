import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'main.dart'; 

/// Widget yang berfungsi sebagai "pintu gerbang" otentikasi aplikasi.
///
/// Tujuannya adalah untuk memeriksa status login pengguna secara real-time
/// dan mengarahkan mereka ke halaman yang sesuai (HomePage jika sudah login,
/// atau LoginDemo jika belum).
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder mendengarkan perubahan pada stream FirebaseAuth.instance.authStateChanges().
    // Stream ini akan memberikan update setiap kali pengguna login atau logout.
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Saat koneksi ke stream sedang aktif dan menunggu data pertama.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        // Jika snapshot memiliki data (objek User tidak null), artinya pengguna sudah login.
        if (snapshot.hasData) {
          // Arahkan ke halaman utama aplikasi.
          return const HomePage();
        }
        
        // Jika snapshot tidak memiliki data, artinya pengguna belum login.
        return const LoginDemo();
      },
    );
  }
}