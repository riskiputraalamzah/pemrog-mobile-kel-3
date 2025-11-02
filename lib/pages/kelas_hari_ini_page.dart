import 'package:flutter/material.dart';
import '../models/jadwal_kuliah.dart';
import 'detail_jadwal_page.dart';

// ------------------------------------------------------------
// kelas_hari_ini_page.dart — versi dengan komentar penjelasan per bagian
// Tujuan: menjelaskan setiap blok kode agar mudah dipahami pemula
// ------------------------------------------------------------

// Kelas KelasHariIniPage menampilkan daftar mata kuliah untuk hari tertentu
// Cara baca: class KelasHariIniPage extends StatelessWidget -> ini widget statis (tidak menyimpan state)
class KelasHariIniPage extends StatelessWidget {
  // Properti hariIni: daftar objek JadwalKuliah yang akan ditampilkan
  final List<JadwalKuliah> hariIni;

  // Constructor: saat membuat halaman ini, wajib memberikan parameter 'hariIni'
  const KelasHariIniPage({Key? key, required this.hariIni}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar layar
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        // Background gradient kuning (amber)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.amber.shade100, Colors.amber.shade300],
          ),
        ),
        child: SafeArea(
          // SafeArea memastikan konten tidak tertutup status bar
          child: Column(
            children: [
              // Header: tombol kembali, judul, dan indikator jumlah kelas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    // Tombol kembali (panah kiri)
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context), // kembali ke halaman sebelumnya
                    ),
                    const Text(
                      'Kelas Hari Ini',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(), // spacer mendorong widget berikutnya ke kanan

                    // Kotak kecil yang menampilkan jumlah kelas hari ini
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.amber),
                          const SizedBox(width: 6),
                          // Menampilkan jumlah item di list hariIni
                          Text('${hariIni.length} Kelas', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Jika list kosong -> tampilkan pesan tidak ada kelas
              if (hariIni.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, size: 56, color: Colors.amber.shade400),
                        const SizedBox(height: 12),
                        Text('Tidak ada kelas untuk hari ini', style: TextStyle(color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                )
              else
                // Jika ada isi -> tampilkan ListView.separated supaya rapi dengan jarak antar item
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    itemCount: hariIni.length, // berapa banyak item
                    separatorBuilder: (_, __) => const SizedBox(height: 12), // jarak antar item
                    itemBuilder: (context, index) {
                      final j = hariIni[index]; // ambil jadwal pada posisi index
                      return _buildKelasCard(context, j); // panggil helper buat kartu
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: membuat kartu untuk setiap jadwal
  Widget _buildKelasCard(BuildContext context, JadwalKuliah jadwal) {
    final Color stripe = jadwal.color; // warna strip samping diambil dari jadwal
    return Material(
      color: Colors.white,
      elevation: 4, // bayangan untuk efek 'terangkat'
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          // Saat kartu diklik, navigasi ke halaman detail jadwal
          Navigator.push(context, MaterialPageRoute(builder: (_) => DetailJadwalPage(jadwal: jadwal)));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Strip berwarna di sisi kiri sebagai penanda warna mata kuliah
              Container(
                width: 6,
                height: 74,
                decoration: BoxDecoration(
                  color: stripe,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 12),

              // Informasi utama: nama mata kuliah, dosen, hari, waktu, ruangan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jadwal.mataKuliah,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      jadwal.dosen,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: stripe),
                        const SizedBox(width: 6),
                        Text(
                          jadwal.hari.toUpperCase(), // tampilkan hari huruf besar
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.access_time, size: 14, color: stripe),
                        const SizedBox(width: 6),
                        Text(jadwal.waktu, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                        const SizedBox(width: 12),
                        Icon(Icons.room, size: 14, color: stripe),
                        const SizedBox(width: 6),
                        // Jika ruangan kosong, tampilkan teks 'Belum tersedia'
                        Text((jadwal.ruangan.isNotEmpty) ? jadwal.ruangan : 'Belum tersedia',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                      ],
                    ),
                  ],
                ),
              ),

              // Kotak kecil di kanan yang menampilkan jumlah SKS
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: stripe.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${jadwal.sks} SKS',
                  style: TextStyle(fontWeight: FontWeight.bold, color: stripe),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
