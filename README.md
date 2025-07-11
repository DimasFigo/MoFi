
# MoFi - Movie Figo App

MoFi (Movie Figo) adalah aplikasi Flutter yang memudahkan pengguna untuk menemukan film terbaru dan informasi terkait seperti genre, sinopsis, trailer, dan rating. Aplikasi ini menggunakan antarmuka yang ramah pengguna dengan berbagai fitur menarik untuk pengalaman menonton yang lebih baik.

## Fitur Utama
- **Login Page**: Pengguna dapat masuk ke aplikasi dengan email dan password.
- **Home Page**: Menampilkan berbagai pilihan genre film yang dapat dipilih oleh pengguna.
- **Film Detail Pages**: Setiap film memiliki halaman detail yang memuat informasi seperti sinopsis, rating, dan trailer.
- **Rating System**: Pengguna dapat memberikan rating untuk film yang mereka pilih.
- **Like Button**: Pengguna bisa menyukai film tertentu.
- **Navigation**: Aplikasi memiliki menu navigasi untuk berpindah antar halaman.

## Teknologi yang Digunakan
- **Flutter**: Framework untuk membangun aplikasi mobile yang cepat dan responsif.
- **Dart**: Bahasa pemrograman yang digunakan di Flutter.
- **Material Design**: Desain antarmuka modern untuk pengalaman pengguna yang menyenangkan.

## Instalasi

### Prasyarat
- **Flutter**: Pastikan sudah menginstall [Flutter SDK](https://flutter.dev/docs/get-started/install).
- **Android Studio**: Untuk emulator Android dan alat pengembangan.
- **Xcode**: Untuk pengembangan iOS (jika di Mac).

### Langkah-langkah instalasi:
1. **Clone repository**:
    ```bash
    git clone https://github.com/username/MoFi.git
    ```

2. **Masuk ke folder project**:
    ```bash
    cd MoFi
    ```

3. **Instal dependensi**:
    ```bash
    flutter pub get
    ```

4. **Jalankan aplikasi di emulator atau perangkat fisik**:
    ```bash
    flutter run
    ```

## Struktur Direktori

```
MoFi/
├── assets/                  # Folder berisi gambar dan media lainnya
│   └── images/
│       └── mofi.png
│       └── thunderbolts.jpg
│       └── havoc.jpeg
│       └── sinners.jpg
├── lib/                     # Folder kode sumber aplikasi
│   ├── main.dart            # Entry point aplikasi (loginpage)
│   ├── homepage.dart        # Halaman utama (HomePage)
│   ├── havoc_page.dart      # Halaman detail film 'Havoc'
│   ├── thunderbolts_page.dart # Halaman detail film 'Thunderbolts'
│   └── sinners_page.dart    # Halaman detail film 'Sinners'
└── pubspec.yaml             # File konfigurasi Flutter project
```

## Cara Menambahkan Film Baru
1. Buka file `homepage.dart` dan tambahkan film baru pada bagian daftar film.
2. Pastikan untuk menambahkan gambar film di folder `assets/images/` dan memasukkan path gambar tersebut.
3. Buat halaman baru untuk film tersebut (misalnya `film_name_page.dart`) dan sesuaikan struktur halaman seperti pada film lainnya (Thunderbolts, Havoc, dll).




