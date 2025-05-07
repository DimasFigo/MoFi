// mengimport semua package dan file halaman yang digunakan
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const MovieGoApp());
}

// ini adalah membuat halaman dengan statelesswidget tidak interaktif
class MovieGoApp extends StatelessWidget {
  const MovieGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoFi',
      debugShowCheckedModeBanner: false,
      home: const LoginDemo(),
    );
  }
}

// ini adalah halaman login
class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
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
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA259FF), // ungu terang
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),

            // ini adalah logo apk yang terdapat pada file assets/images
            SizedBox(
              width: 200,
              height: 150,
              child: Image.asset('assets/images/mofi.png'),
            ),
            const SizedBox(height: 30),

            // ini form unyuk memasukkan email
            const TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'you@example.com',
                hintStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ini form untuk memasukkan password
            const TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),

            // ini menu forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                // ini untuk ketika diklick maka akan mengarahkan tetapi belum digunakan
                onPressed: () {
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFFBB86FC),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ini adalah menu login
            ElevatedButton(
              // ini adalah ketika menu login di tekan akan mengarahkan ke HomePage
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4D8), // biru neon
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 80),

            // ini untuk menu create account tetapi masih belum bisa digunakan hanya text biasa
            const Text(
              'New to MoFi? Create Account',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
