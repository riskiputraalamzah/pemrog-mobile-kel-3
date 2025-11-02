import 'package:flutter/material.dart';

// ------------------------------------------------------------
// detail_akademik_page.dart — versi dengan penjelasan per baris
// Setiap bagian penting diberi komentar singkat:
// - apa fungsinya
// - cara "membaca" baris itu untuk pemula
// - catatan kecil bila perlu
// ------------------------------------------------------------

// Deklarasi class DetailAkademikPage sebagai StatelessWidget
// Cara baca: "class DetailAkademikPage extends StatelessWidget" ->
// kita membuat komponen tampilan yang tidak menyimpan state (tidak berubah sendiri)
class DetailAkademikPage extends StatelessWidget {
  // Properti yang akan diisi saat membuat halaman ini
  // title: judul detail (misal 'IPK' atau 'Total SKS')
  // value: nilai yang ditampilkan (misal '3.85' atau '120/144')
  // icon: ikon yang ditampilkan di bagian atas kartu
  // color: warna utama untuk tema halaman
  final String title;
  final String value;
  final IconData icon;
  final MaterialColor color;

  // Constructor: cara membuat instance DetailAkademikPage
  // Cara baca: const DetailAkademikPage({required this.title, ...})
  // artinya: saat membuat halaman ini, kita wajib memberi title, value, icon, color
  const DetailAkademikPage({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  // build() bertugas menggambar UI. Flutter memanggil ini untuk menampilkan halaman.
  Widget build(BuildContext context) {
    // Scaffold = struktur dasar layar (biasanya berisi appBar, body, dsb.)
    return Scaffold(
      body: Container(
        // Decoration menentukan latar belakang container
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // Menggunakan shade dari warna yang diberikan untuk membuat gradasi
            colors: [color.shade100, color.shade300],
          ),
        ),
        // SafeArea memastikan isi tidak tertutup status bar / notch
        child: SafeArea(
          child: Column(
            children: [
              // Bagian header: tombol kembali dan judul
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // IconButton untuk kembali ke halaman sebelumnya
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                      // Cara baca: saat tombol ditekan, Navigator.pop(context) mengeluarkan halaman ini
                    ),
                    // Judul halaman: tampilkan "Detail {title}"
                    Text(
                      'Detail $title',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Expanded mengambil sisa ruang layar agar konten utama berada di tengah
              Expanded(
                child: Center(
                  // TweenAnimationBuilder memberi animasi "scale" saat widget muncul
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.elasticOut,
                    // builder dipanggil tiap frame animasi; 'value' bergerak dari 0 ke 1
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value, // ketika value=0 -> scale=0 (tidak terlihat). value=1 -> normal
                        child: child, // child adalah container statis yang dianimasikan
                      );
                    },

                    // child di sini adalah widget yang tidak berubah selama animasi
                    child: Container(
                      margin: const EdgeInsets.all(32),
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Lingkaran besar berisi ikon
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color.shade300, color.shade600],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(icon, size: 64, color: Colors.white),
                          ),

                          const SizedBox(height: 24),

                          // Teks judul (misalnya 'IPK' atau 'Total SKS')
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Teks nilai utama (angka besar)
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: color.shade700,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Kondisional: jika title == 'IPK' maka tampilkan baris detail IPK
                          // Jika bukan IPK (misal 'Total SKS'), tampilkan detail SKS
                          if (title == 'IPK') ...[
                            // _buildDetailRow adalah helper method (di bawah) untuk baris label-value
                            _buildDetailRow('Semester', '7', color),
                            _buildDetailRow('Predikat', 'Cum Laude', color),
                            _buildDetailRow('Peringkat', '5 dari 150', color),
                          ] else ...[
                            // value berformat 'sksSelesai/totalSKS' jadi kita split berdasarkan '/'
                            _buildDetailRow('SKS Lulus', value.split('/')[0], color),
                            _buildDetailRow('SKS Total', value.split('/')[1], color),
                            _buildDetailRow('Sisa SKS', 
                              // hitung sisa dengan cara konversi string ke int
                              '${int.parse(value.split('/')[1]) - int.parse(value.split('/')[0])}', 
                              color
                            ),
                          ],
                        ],
                      ),
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

  // Helper method: membuat baris label dan value di detail
  Widget _buildDetailRow(String label, String value, MaterialColor color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // label di kiri, value di kanan
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
