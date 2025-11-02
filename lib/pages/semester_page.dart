import 'package:flutter/material.dart';

// ------------------------------------------------------------
// semester_page.dart — file ini menampilkan informasi semester aktif
// Versi ini berisi komentar per-bagian untuk pemula: apa fungsi tiap blok
// ------------------------------------------------------------

// SemesterPage adalah halaman statis (StatelessWidget) karena tidak menyimpan state
class SemesterPage extends StatelessWidget {
  const SemesterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur layar dasar
    return Scaffold(
      body: Container(
        // Background gradient berwarna cyan
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.cyan.shade100, Colors.cyan.shade300],
          ),
        ),
        child: SafeArea(
          // SafeArea agar isi tidak tertutup bagian atas layar (notch/status bar)
          child: Column(
            children: [
              // Header: tombol kembali + judul
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context), // kembali ke halaman sebelumnya
                    ),
                    const Text(
                      'Informasi Semester',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Konten utama: kartu putih di tengah layar
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(32),
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // ukuran kolom sesuaikan isi
                      children: [
                        // Lingkaran berisi ikon sekolah
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.cyan.shade300, Colors.cyan.shade600],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.school, size: 64, color: Colors.white),
                        ),
                        const SizedBox(height: 24),

                        // Teks judul kecil
                        const Text(
                          'Semester Aktif',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Nilai semester (angka besar)
                        Text(
                          '7',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan.shade700,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Baris detail (tahun akademik, periode, status)
                        _buildSemesterDetail('Tahun Akademik', '2025/2026', Colors.cyan),
                        _buildSemesterDetail('Periode', 'Ganjil', Colors.cyan),
                        _buildSemesterDetail('Status', 'Aktif', Colors.cyan),
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

  // Helper statis: membuat baris label dan nilai untuk detail semester
  // static karena tidak bergantung pada instance kelas
  static Widget _buildSemesterDetail(String label, String value, MaterialColor color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // label kiri, nilai di kanan
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
