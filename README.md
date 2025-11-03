#  Dashboard Akademik (Tugas 3 Pemrograman Mobile)

Ini adalah proyek aplikasi Flutter yang dibuat untuk memenuhi tugas Kelompok 3 mata kuliah Pemrograman Mobile.

Aplikasi ini berupa *dashboard* akademik mahasiswa yang menampilkan data-data penting perkuliahan. Tujuan utamanya adalah untuk "Menampilkan data akademik (IPK, SKS, jadwal kuliah) dengan layout grid dan navigasi ke detail."

## 👥 Anggota Kelompok 3

1. Brigide Tirenia A Loresta (221080200020)
2. Indri Arianti Wibowo (2210802000005)
3. Muhammad Sulthon Abiyyu (221080200036)
4. Niko Dwi Novana (221080200073)
5. Amalia Rossa Annjani (221080200023
6. M. Aufa Izul Haq (221080200021)
7. Riski Putra Alamzah (221080200100)
8. Adieb Aufa Musthafa Putra (231080200006)		



## ✨ Fitur Utama

Aplikasi ini memiliki beberapa fitur utama yang terbagi dalam beberapa halaman:

* **Dashboard Utama (`dashboard_page.dart`)**: Halaman beranda yang menampilkan ringkasan IPK, SKS, dan daftar jadwal kuliah semester.
* **Menu Cepat**: Navigasi cepat ke halaman:
    * **Kelas Hari Ini (`kelas_hari_ini_page.dart`)**: Menampilkan jadwal mata kuliah yang ada pada hari ini.
    * **Tugas Aktif (`tugas_aktif_page.dart`)**: Daftar tugas yang sedang aktif atau memiliki tenggat waktu.
    * **Info Semester (`semester_page.dart`)**: Menampilkan detail semester yang sedang berjalan.
* **Halaman Detail**:
    * **Detail Akademik (`detail_akademik_page.dart`)**: Menampilkan rincian lebih lanjut saat kartu IPK atau SKS di-klik.
    * **Detail Jadwal (`detail_jadwal_page.dart`)**: Menampilkan rincian lengkap satu mata kuliah (dosen, waktu, ruangan, SKS).
* **Model Data**: Menggunakan model data kustom (`academic_data.dart` dan `jadwal_kuliah.dart`) untuk mengelola informasi secara terstruktur.

## 🛠️ Teknologi yang Digunakan

* **Flutter**: Framework utama untuk membangun aplikasi *multi-platform* dari satu basis kode.
* **Dart**: Bahasa pemrograman yang digunakan oleh Flutter.
* **Docker & Nginx (Web)**: Proyek ini juga menyertakan `Dockerfile`, `docker-compose.yml`, dan `nginx.conf` untuk memudahkan proses *build* dan *deployment* aplikasi Flutter versi Web.

## 🚀 Cara Menjalankan Proyek

1.  Pastikan Anda memiliki [Flutter SDK](https://flutter.dev/docs/get-started/install) terinstal di komputer Anda.
2.  *Clone* repositori ini:
    ```bash
    git clone https://github.com/riskiputraalamzah/pemrog-mobile-kel-3
    cd pemrog-mobile-kel-3
    ```
3.  Instal semua dependensi yang dibutuhkan:
    ```bash
    flutter pub get
    ```
4.  Jalankan aplikasi (pilih *device* target Anda, seperti Android, iOS, atau Web):
    ```bash
    flutter run
    ```
    Untuk menjalankan di web:
    ```bash
    flutter run -d chrome
    ```

---
