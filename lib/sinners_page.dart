// mengimport semua package yang digunakan
import 'package:flutter/material.dart';

// ini adalah membuat halaman dengan statelesswidget tidak interaktif
class SinnersPage extends StatelessWidget {
  const SinnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ini adalah header judul
      appBar: AppBar(
        title: const Text('Sinners'),
        backgroundColor: const Color(0xFFA259FF),
      ),
      // ini adalah body yang berisi text saja
      body: const Center(
        child: Text('This is the Sinners page!'),
      ),
    );
  }
}
