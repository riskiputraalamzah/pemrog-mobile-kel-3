// Mengimpor (memanggil) file lain bernama 'jadwal_kuliah.dart'
// supaya kita bisa menggunakan class atau data dari file itu di sini.
import 'jadwal_kuliah.dart';

// Membuat sebuah class bernama 'AcademicData'
// Class ini seperti cetakan / blueprint untuk menyimpan data akademik seorang mahasiswa.
class AcademicData {
  // 'final' artinya nilai-nilai ini tidak bisa diubah lagi setelah dibuat (bersifat tetap).
  // Di bawah ini adalah properti atau "isi" dari class ini.

  // ipk = Indeks Prestasi Kumulatif (contoh: 3.85)
  final double ipk;

  // totalSKS = jumlah total SKS yang harus ditempuh selama kuliah (misal: 144 SKS)
  final int totalSKS;

  // sksSelesai = jumlah SKS yang sudah diselesaikan oleh mahasiswa (misal: 90 SKS)
  final int sksSelesai;

  // jadwalList = daftar jadwal kuliah (tipe datanya List<JadwalKuliah>)
  // artinya: ini adalah kumpulan data jadwal kuliah, dan setiap item-nya
  // merupakan object dari class JadwalKuliah yang diambil dari file jadwal_kuliah.dart
  final List<JadwalKuliah> jadwalList;

  // Ini adalah "constructor" — bagian yang dijalankan saat membuat object dari class ini.
  // 'required' berarti semua data di dalam tanda kurung wajib diisi.
  AcademicData({
    required this.ipk,         // nilai IPK wajib diisi
    required this.totalSKS,    // total SKS wajib diisi
    required this.sksSelesai,  // SKS selesai wajib diisi
    required this.jadwalList,  // daftar jadwal wajib diisi
  });
}
