import 'package:flutter/material.dart';

// ------------------------------------------------------------
// DashboardPage (file ini) — versi dengan penjelasan per baris/kata
// Setiap baris utama diberi komentar yang menjelaskan:
// 1) apa fungsi baris itu, 2) bagaimana "cara baca" (interpretasi sederhana),
// 3) catatan kecil untuk pemula.
// ------------------------------------------------------------

// Mengimpor file model: AcademicData dan JadwalKuliah
// Cara baca: "import '../models/academic_data.dart'" -> ambil kode dari file lain di folder models
import '../models/academic_data.dart';
import '../models/jadwal_kuliah.dart';

// Mengimpor halaman-halaman lain yang akan dipakai untuk navigasi
// Cara baca: import 'kelas_hari_ini_page.dart' -> file di folder yang sama
import 'kelas_hari_ini_page.dart';
import 'tugas_aktif_page.dart';
import 'semester_page.dart';
import 'detail_akademik_page.dart';
import 'detail_jadwal_page.dart';

// ------------------------------------------------------------
// Definisi widget: DashboardPage
// "class DashboardPage extends StatefulWidget" -> buat komponen yang punya "state" (bisa berubah)
// Cara baca: class [Nama] extends [Tipe] --> ini membuat tipe baru berdasarkan tipe yang sudah ada
class DashboardPage extends StatefulWidget {
  // constructor: membuat instance baru dari DashboardPage
  // Cara baca: const DashboardPage({Key? key}) : super(key: key);
  // artinya: kita punya fungsi pembuat (constructor) yang menerima parameter optional "key"
  const DashboardPage({Key? key}) : super(key: key);

  @override
  // createState() -> menghubungkan StatefulWidget dengan objek State yang menyimpan data yang berubah
  // Cara baca: ketika Flutter mau menjalankan DashboardPage, ia akan panggil createState() untuk mendapatkan _DashboardPageState
  State<DashboardPage> createState() => _DashboardPageState();
}

// ------------------------------------------------------------
// Kelas _DashboardPageState: tempat semua logika, data sementara, dan tampilan aktual
// "with TickerProviderStateMixin" -> memberi kemampuan menyediakan "vsync" untuk animasi
class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  // Deklarasi variabel animasi. "late" artinya: akan diisi nanti (dalam initState)
  // AnimationController -> controller yang mengatur jalannya animasi (mulai, stop, dsb.)
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation; // animasi untuk opacity (nilai double 0.0-1.0)
  late Animation<Offset> _slideAnimation; // animasi untuk posisi (Offset x,y)

  // Contoh data statis (hardcoded) untuk demo.
  // academicData adalah instance dari AcademicData (model yang diimpor di atas)
  final AcademicData academicData = AcademicData(
    ipk: 3.85, // field ipk -> angka
    totalSKS: 144, // field totalSKS -> angka
    sksSelesai: 120, // field sksSelesai -> angka
    jadwalList: [
      // daftar JadwalKuliah; tiap item adalah objek JadwalKuliah
      JadwalKuliah(
        mataKuliah: 'INF23751 - DESAIN DAN APLIKASI MULTIMEDIA*', // string nama mata kuliah
        dosen: 'Cindy Taurusta, S.ST., MT.',
        hari: 'KAMIS',
        waktu: '(13:20)',
        ruangan: 'A1 (Kampus 2, Jl. Raya Gelam No. 250 Candi - Sidoarjo, GKB 5, 403 Ruang Kelas)',
        sks: (3), // jumlah SKS
        color: Colors.blue, // warna identifikasi
      ),
      JadwalKuliah(
        mataKuliah: 'INF23748 - WEB DAN TEXT MINING*',
        dosen: 'Yulian Findawati, ST., M.MT.',
        hari: 'SENIN',
        waktu: '(10:20)',
        ruangan: 'A1 (Kampus 2, Jl. Raya Gelam No. 250 Candi - Sidoarjo, GKB 5, 403 Ruang Kelas)',
        sks: (3),
        color: Colors.purple,
      ),
      JadwalKuliah(
        mataKuliah: 'INF23749 - ETICHAL HACKING*',
        dosen: 'Azmuri Wahyu Azinar, ST., M.Comp.',
        hari: 'KAMIS',
        waktu: '(10:20)',
        ruangan: 'A2 (Kampus 2, Jl. Raya Gelam No. 250 Candi - Sidoarjo, GKB 5, 404 Ruang Kelas)',
        sks: (3),
        color: Colors.orange,
      ),
      JadwalKuliah(
        mataKuliah: 'INF23634 - PENGOLAHAN CITRA DIGITAL',
        dosen: 'Suhendro Busono, S.ST., M.Kom.',
        hari: 'KAMIS',
        waktu: '(07:50)',
        ruangan: 'A2 (Kampus 2, Jl. Raya Gelam No. 250 Candi - Sidoarjo, GKB 5, 404 Ruang Kelas)',
        sks: (3),
        color: Colors.red,
      ),
      JadwalKuliah(
        mataKuliah: 'INF23531 - PEMROGRAMAN MOBILE',
        dosen: 'Moch. Fauzan, S.Kom., M.Kom',
        hari: 'JUM`AT',
        waktu: '(07:50)',
        ruangan: 'A1 (Kampus 2, Jl. Raya Gelam No. 250 Candi - Sidoarjo, Laboratorium Center K2, Lab. Sistem Cerdas)',
        sks: (3),
        color: Colors.teal,
      ),
    ],
  );

  // initState() dipanggil sekali saat objek state dibuat
  @override
  void initState() {
    super.initState(); // panggil parent initState dulu

    // Inisialisasi controller untuk efek fade (transisi opacity)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000), // lama animasi: 1000ms = 1 detik
      vsync: this, // 'this' karena kelas ini memiliki TickerProvider melalui mixin
    );

    // Inisialisasi controller untuk efek slide (pergeseran posisi)
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Tween: nilai dari 0.0 (transparan) ke 1.0 (penuh)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // Tween untuk posisi: mulai agak turun (0, 0.3) lalu ke posisi normal (0,0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Jalankan animasi
    _fadeController.forward(); // mulai animasi fade
    _slideController.forward(); // mulai animasi slide
  }

  // dispose() dipanggil saat widget dihapus; bersihkan resource di sini
  @override
  void dispose() {
    _fadeController.dispose(); // hentikan & buang controller
    _slideController.dispose();
    super.dispose();
  }

  // build() -> menggambar UI ke layar. Setiap kali setState dipanggil, build akan dieksekusi lagi
  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar layar (bisa menampung AppBar, body, dsb.)
    return Scaffold(
      backgroundColor: Colors.transparent, // latar belakang scaffold transparan
      body: Container(
        // BoxDecoration dengan gradient sebagai background halaman
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade50,
              Colors.purple.shade50,
              Colors.pink.shade50,
            ],
          ),
        ),
        // SafeArea memastikan konten tidak terpotong oleh notch / status bar
        child: SafeArea(
          // Gabungkan FadeTransition dan SlideTransition agar widget muncul dengan efek
          child: FadeTransition(
            opacity: _fadeAnimation, // gunakan animasi opacity yang sudah didefinisikan
            child: SlideTransition(
              position: _slideAnimation, // gunakan animasi posisi
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(), // efek scroll "bounce"
                slivers: [
                  // SliverToBoxAdapter untuk menaruh widget biasa di dalam CustomScrollView
                  SliverToBoxAdapter(
                    child: _buildCustomAppBar(), // panggil method yang membuat header
                  ),

                  // SliverPadding berisi konten utama: academic info dan jadwal
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildAcademicInfoSection(), // metode untuk bagian IPK & SKS
                        const SizedBox(height: 20),
                        _buildScheduleSection(), // metode untuk daftar jadwal
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===================== Header / Custom App Bar =====================
  Widget _buildCustomAppBar() {
    // ClipRRect untuk memberi rounded corner pada bagian bawah header
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      child: Container(
        width: double.infinity, // lebar penuh
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/3.jpg'), // gambar latar header
            fit: BoxFit.cover, // gambar menutupi seluruh area
          ),
        ),
        child: Container(
          // overlay gradient di atas gambar supaya teks kontras
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 85, 0, 255).withOpacity(0.85),
                Color.fromARGB(255, 79, 52, 233).withOpacity(0.85),
                Color.fromARGB(255, 130, 98, 226).withOpacity(0.85),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20), // jarak isi dari tepi
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar bundar dengan dua layer CircleAvatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.amber.shade400, Colors.orange.shade500],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 28, // ukuran lingkaran luar
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 26, // lingkaran dalam
                        backgroundColor: Colors.purple.shade100,
                        child: Text(
                          'MT', // inisial yang tampil di avatar
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Nama pengguna dan info singkat (NIM & jurusan)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Kelompok 3! 👋',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black.withOpacity(0.2), offset: Offset(0, 2), blurRadius: 4),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'NIM • Teknik Informatika',
                          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  // Tombol notifikasi (IconButton) + badge merah di pojok
                  Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), shape: BoxShape.circle),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: Colors.white,
                          onPressed: () {
                            // Saat tombol notifikasi diklik, munculkan snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Anda memiliki 3 notifikasi baru'), behavior: SnackBarBehavior.floating),
                            );
                          },
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.red.shade500, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Tombol menu yang memanggil bottom sheet
                  Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), shape: BoxShape.circle),
                    child: IconButton(icon: const Icon(Icons.menu_rounded), color: Colors.white, onPressed: () => _showMenuBottomSheet(context)),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Baris quick stat: tiga card kecil (Kelas Hari Ini, Tugas Aktif, Semester)
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Filter jadwal untuk hari tertentu (contoh: 'kamis')
                        final hariIniList = academicData.jadwalList.where((jadwal) => jadwal.hari.toLowerCase() == 'kamis').toList();
                        // Navigasi ke halaman KelasHariIniPage sambil membawa data
                        Navigator.push(context, MaterialPageRoute(builder: (context) => KelasHariIniPage(hariIni: hariIniList)));
                      },
                      child: _buildQuickStat(icon: Icons.event_note, label: 'Kelas Hari Ini', value: '3', color: Colors.amber),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const TugasAktifPage())), child: _buildQuickStat(icon: Icons.assignment_turned_in, label: 'Tugas Aktif', value: '5', color: Colors.green))),
                  const SizedBox(width: 12),
                  Expanded(child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const SemesterPage())), child: _buildQuickStat(icon: Icons.school, label: 'Semester', value: '7', color: Colors.cyan))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu: membuat kartu kecil di header (ikon + angka + label)
  Widget _buildQuickStat({
    required IconData icon,
    required String label,
    required String value,
    required MaterialColor color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value, // angka yang ditampilkan
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label, // keterangan singkat
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  // Menampilkan bottom sheet berisi menu (Profil, Pengaturan, Bantuan, Keluar)
  void _showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
              _buildMenuItem(Icons.person_outline, 'Profil', Colors.blue),
              _buildMenuItem(Icons.settings_outlined, 'Pengaturan', Colors.purple),
              _buildMenuItem(Icons.help_outline, 'Bantuan', Colors.orange),
              _buildMenuItem(Icons.logout, 'Keluar', Colors.red),
            ],
          ),
        );
      },
    );
  }

  // Item list pada bottom sheet — menggunakan ListTile agar rapih
  Widget _buildMenuItem(IconData icon, String label, MaterialColor color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
      onTap: () {
        // Tutup bottom sheet saat item diklik
        Navigator.pop(context);
        // Tampilkan snack bar sederhana sebagai contoh aksi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label diklik')),
        );
      },
    );
  }

  // ======================= Bagian Informasi Akademik =======================
  Widget _buildAcademicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.pink.shade400],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.analytics, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'Informasi Akademik',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // LayoutBuilder: membaca ukuran parent (constraints) untuk membuat layout responsif
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth; // dapatkan lebar yang tersedia
            final isWide = width > 600; // rule: jika lebar > 600, anggap layar lebar
            final crossAxisCount = isWide ? 2 : 1; // 2 kolom untuk layar lebar
            final childAspectRatio = isWide ? 1.8 : 2.4; // rasio lebar:tinggi kartu

            // GridView.builder: membuat grid dengan jumlah item dinamis
            return GridView.builder(
              shrinkWrap: true, // agar grid tidak mengisi tinggi tak terhingga
              physics: const NeverScrollableScrollPhysics(), // grid tidak scroll sendiri
              itemCount: 2, // jumlah kartu (IPK, Total SKS)
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Kartu IPK
                  return _buildInfoCard(
                    title: 'IPK',
                    value: academicData.ipk.toString(),
                    icon: Icons.star,
                    color: Colors.amber,
                    delay: 0,
                  );
                } else {
                  // Kartu Total SKS
                  return _buildInfoCard(
                    title: 'Total SKS',
                    value: '${academicData.sksSelesai}/${academicData.totalSKS}',
                    icon: Icons.school,
                    color: Colors.green,
                    delay: 100,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  // Widget kartu informasi (bisa digunakan untuk IPK, SKS, dsb.)
  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required MaterialColor color,
    required int delay,
  }) {
    // shouldCenter -> menentukan apakah isi kartu ditampilkan di tengah
    final bool shouldCenter = title.toLowerCase().contains('ipk') ||
        title.toLowerCase().contains('total sks') ||
        title.toLowerCase().contains('sks');

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.8, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
      child: LayoutBuilder(
        builder: (context, outerConstraints) {
          // safeMaxHeight -> jika outerConstraints tidak terbatas, berikan default 220
          final double safeMaxHeight = outerConstraints.maxHeight.isFinite ? outerConstraints.maxHeight : 220.0;
          final double minHeight = 110.0;

          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight, maxHeight: safeMaxHeight.clamp(minHeight, 400.0)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
              ),
              child: Material(
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 90.0, maxHeight: 260.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // Saat kartu diklik, pindah ke halaman detail akademik
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailAkademikPage(title: title, value: value, icon: icon, color: color),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: shouldCenter
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [color.shade300, color.shade600]),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(child: Icon(icon, color: Colors.white, size: 26)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color.shade700),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(title, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(gradient: LinearGradient(colors: [color.shade300, color.shade600]), shape: BoxShape.circle),
                                  child: Icon(icon, color: Colors.white, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(title, style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 4),
                                      Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color.shade700)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ======================= Bagian Jadwal Kuliah =======================
  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.cyan.shade400],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.schedule, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'Jadwal Kuliah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Menampilkan jadwal dengan efek animasi staggered
        ...academicData.jadwalList.asMap().entries.map((entry) {
          int index = entry.key; // index dari map
          JadwalKuliah jadwal = entry.value; // item JadwalKuliah

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 100)), // durasi bertambah per index
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              // nilai 'value' bergerak dari 0 ke 1; gunakan untuk opacity dan translate
              return Opacity(
                opacity: value, // semakin mendekati 1 => semakin tampak
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)), // mulai agak turun, lalu naik ke posisi normal
                  child: child,
                ),
              );
            },
            child: _buildScheduleCard(jadwal), // widget statis yang dianimasikan
          );
        }).toList(),
      ],
    );
  }

  // Kartu untuk tiap jadwal; saat diklik menuju DetailJadwalPage
  Widget _buildScheduleCard(JadwalKuliah jadwal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: jadwal.color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigasi ke halaman detail jadwal, membawa objek jadwal
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailJadwalPage(jadwal: jadwal),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 80,
                  decoration: BoxDecoration(
                    color: jadwal.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jadwal.mataKuliah, // judul mata kuliah
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        jadwal.dosen, // nama dosen
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, 
                            size: 14, 
                            color: jadwal.color
                          ),
                          const SizedBox(width: 4),
                          Text(
                            jadwal.hari, // hari kuliah
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.access_time, 
                            size: 14, 
                            color: jadwal.color
                          ),
                          const SizedBox(width: 4),
                          Text(
                            jadwal.waktu, // waktu kuliah
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: jadwal.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${jadwal.sks} SKS', // jumlah SKS di kanan kartu
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: jadwal.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
