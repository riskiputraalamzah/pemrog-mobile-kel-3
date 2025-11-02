import 'package:flutter/material.dart';
import '../models/jadwal_kuliah.dart';

// ------------------------------------------------------------
// detail_jadwal_page.dart — versi dengan penjelasan per bagian
// Komentar menjelaskan apa fungsi setiap blok dan cara 'membaca' barisnya
// Bahasa: Indonesia, ditujukan untuk pemula
// ------------------------------------------------------------

// DetailJadwalPage: halaman untuk menampilkan detail satu jadwal kuliah
// Cara baca: class DetailJadwalPage extends StatelessWidget -> komponen ini statis (tidak menyimpan state)
class DetailJadwalPage extends StatelessWidget {
  // Properti yang diterima saat membuat halaman ini
  final JadwalKuliah jadwal; // objek jadwal berisi mataKuliah, dosen, hari, waktu, ruangan, sks, color

  // Constructor: saat memanggil DetailJadwalPage, harus memberikan 'jadwal'
  const DetailJadwalPage({Key? key, required this.jadwal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold = struktur dasar layar
    return Scaffold(
      body: Container(
        // Background gradient menggunakan warna dari jadwal (jadwal.color)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [jadwal.color.shade100, jadwal.color.shade300],
          ),
        ),
        child: SafeArea(
          // SafeArea menjaga agar konten tidak tertimpa status bar/notch
          child: Column(
            children: [
              // Bagian header kecil: tombol kembali + judul
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // IconButton: panah kembali. onPressed: Navigator.pop(context) membuat kembali ke halaman sebelumnya
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Detail Jadwal Kuliah',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Expanded agar isi berikutnya mengisi sisa layar
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  // TweenAnimationBuilder untuk animasi masuk (fade + slide)
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOut,
                    // builder dipanggil tiap frame animasi; 'value' bergerak dari 0 ke 1
                    builder: (context, value, child) {
                      // Opacity = mengubah transparansi; Transform.translate = geser posisi vertikal
                      return Opacity(
                        opacity: value, // value 0 => transparan, 1 => penuh
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)), // saat value=0 offset=20 (tergeser ke bawah), saat value=1 offset=0
                          child: child,
                        ),
                      );
                    },

                    // child statis — widget ini yang akan dianimasikan
                    child: Column(
                      children: [
                        // Kartu utama berwarna putih dengan shadow
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: jadwal.color.withOpacity(0.3),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Lingkaran berisi ikon buku
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [jadwal.color.shade300, jadwal.color.shade600],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.book,
                                  size: 64,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Nama mata kuliah (judul besar)
                              Text(
                                jadwal.mataKuliah,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: jadwal.color.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Label kecil menunjukkan jumlah SKS
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: jadwal.color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${jadwal.sks} SKS',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: jadwal.color.shade700,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),
                              const Divider(), // garis pemisah
                              const SizedBox(height: 24),

                              // Detail baris: dosen, hari, waktu, ruangan
                              _buildDetailItem(
                                icon: Icons.person,
                                label: 'Dosen Pengampu',
                                value: jadwal.dosen,
                                color: jadwal.color,
                              ),
                              const SizedBox(height: 20),

                              _buildDetailItem(
                                icon: Icons.calendar_today,
                                label: 'Hari',
                                value: jadwal.hari,
                                color: jadwal.color,
                              ),
                              const SizedBox(height: 20),

                              _buildDetailItem(
                                icon: Icons.access_time,
                                label: 'Waktu',
                                value: jadwal.waktu,
                                color: jadwal.color,
                              ),
                              const SizedBox(height: 20),

                              _buildDetailItem(
                                icon: Icons.room,
                                label: 'Ruangan',
                                value: jadwal.ruangan,
                                color: jadwal.color,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Tombol aksi: Absensi dan Materi
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Contoh aksi: tampilkan SnackBar sementara fitur belum ada
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Absensi akan segera hadir'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('Absensi'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: jadwal.color,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Materi akan segera hadir'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.folder_outlined, color: jadwal.color),
                                label: Text('Materi', style: TextStyle(color: jadwal.color)),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(color: jadwal.color, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget: baris detail dengan ikon + label + value
  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        // Kotak kecil berisi ikon
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),

        // Expanded agar teks mengambil ruang yang tersisa
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
