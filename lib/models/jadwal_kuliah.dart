// Mengimpor paket Flutter bawaan yang berisi class 'Color' dan 'MaterialColor'.
// Ini dibutuhkan supaya kita bisa memberi warna pada jadwal kuliah.
import 'package:flutter/material.dart';

// Membuat class bernama 'JadwalKuliah'.
// Class ini digunakan untuk menyimpan 1 data jadwal kuliah.
class JadwalKuliah {
  // Berikut ini adalah daftar "atribut" atau "isi data" dari setiap jadwal kuliah.

  // Nama mata kuliah, contoh: "Pemrograman Mobile"
  final String mataKuliah;

  // Nama dosen pengajar, contoh: "Dr. Andi Saputra, M.Kom"
  final String dosen;

  // Hari kuliah, contoh: "Senin", "Rabu", dll.
  final String hari;

  // Waktu kuliah, contoh: "08.00 - 09.40"
  final String waktu;

  // Nama ruangan tempat kuliah, contoh: "Lab Komputer 1"
  final String ruangan;

  // Jumlah SKS dari mata kuliah tersebut, contoh: 3
  final int sks;

  // Warna tema (biasanya digunakan untuk tampilan di UI)
  // Misalnya setiap jadwal punya warna latar berbeda agar mudah dibedakan di tampilan.
  final MaterialColor color;

  // Constructor — digunakan saat ingin membuat object baru dari class ini.
  // 'required' artinya semua nilai ini wajib diisi.
  JadwalKuliah({
    required this.mataKuliah,  // wajib isi nama mata kuliah
    required this.dosen,       // wajib isi nama dosen
    required this.hari,        // wajib isi hari
    required this.waktu,       // wajib isi waktu
    required this.ruangan,     // wajib isi ruangan
    required this.sks,         // wajib isi jumlah SKS
    required this.color,       // wajib isi warna
  });
}
