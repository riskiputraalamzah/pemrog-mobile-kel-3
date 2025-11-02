    // Mengimpor (memanggil) library bawaan Flutter
    // 'material.dart' berisi semua widget tampilan seperti tombol, teks, warna, dsb.
import 'package:flutter/material.dart';

    // Mengimpor file lain buatan kita sendiri yaitu 'dashboard_page.dart'
    // File ini berisi tampilan utama aplikasi (halaman Dashboard)
import 'pages/dashboard_page.dart';

    // Fungsi utama (pintu masuk aplikasi)
    // Setiap program Dart selalu dimulai dari fungsi main()
void main() {
    // runApp() berfungsi untuk menjalankan aplikasi Flutter ke layar
    // Di sini, kita jalankan aplikasi dengan class MyApp sebagai tampilan utamanya
  runApp(const MyApp());
}

    // Membuat class utama aplikasi bernama MyApp
    // StatelessWidget artinya tampilan ini tidak bisa berubah (statis)
    // Kalau nanti kamu butuh tampilan yang bisa berubah (misal warna berubah saat klik tombol),
    // kamu akan pakai StatefulWidget
class MyApp extends StatelessWidget {
    // Constructor bawaan dari Flutter, biasanya untuk keperluan identitas widget
  const MyApp({Key? key}) : super(key: key);

      // Fungsi build() ini wajib ada di setiap widget
      // Fungsi ini berisi "tampilan" yang akan muncul di layar
  @override
  Widget build(BuildContext context) {
        // MaterialApp adalah widget utama yang mengatur gaya tampilan aplikasi
        // Bisa dibilang ini seperti "kerangka besar" dari seluruh aplikasi
    return MaterialApp(
          // Judul aplikasi, biasanya muncul di task manager atau bagian atas aplikasi
      title: 'Dashboard Akademik',

          // Menghilangkan tulisan kecil "DEBUG" di pojok kanan atas saat mode debug
      debugShowCheckedModeBanner: false,

          // Mengatur tema (warna, font, dan gaya umum aplikasi)
      theme: ThemeData(
            // Warna utama aplikasi adalah biru
        primarySwatch: Colors.blue,

            // Mengatur agar tampilan menggunakan mode terang (light mode)
        brightness: Brightness.light,

            // Mengatur font default menjadi Poppins (pastikan font ini sudah ditambahkan di pubspec.yaml)
        fontFamily: 'Poppins',
      ),

          // Menentukan halaman pertama (beranda) yang akan muncul saat aplikasi dibuka
          // Di sini kita arahkan ke halaman DashboardPage (yang diambil dari file dashboard_page.dart)
      home: const DashboardPage(),
    );
  }
}
