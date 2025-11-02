import 'package:flutter/material.dart';

// ------------------------------------------------------------
// tugas_aktif_page.dart — versi dengan komentar penjelasan per blok
// Tujuan: menjelaskan setiap bagian supaya mudah dipahami pemula
// ------------------------------------------------------------

// Halaman TugasAktifPage menampilkan daftar tugas yang sedang aktif
class TugasAktifPage extends StatelessWidget {
  const TugasAktifPage({Key? key}) : super(key: key);

  // Getter _tasks mengembalikan daftar tugas contoh (hardcoded)
  // Cara baca: tiap item adalah Map berisi title, task, dosen, due, progress, warna, dan priority
  List<Map<String, dynamic>> get _tasks => [
        {
          'title': 'Pemrograman Mobile',
          'task': 'Tugas 3: Buat website sesuai judul yang ditentukan di setiap kelompok.',
          'dosen': 'Moch. Fauzan, S.Kom., M.Kom',
          'due': '2025-11-10', // tanggal deadline (format string)
          'progress': 0.25, // progress 0.0 - 1.0
          'color': Colors.teal.shade600, // warna untuk kartu
          'priority': 'Tugas 3',
        },
        {
          'title': 'Desain dan Aplikasi Multimedia',
          'task': 'Tugas 2: Buat 1 foto bagus hasil potret sendiri.',
          'dosen': 'Cindy Taurusta, S.ST., MT.',
          'due': '2025-11-08',
          'progress': 0.5,
          'color': Colors.purple.shade600,
          'priority': 'Tugas 2',
        },
        {
          'title': 'Web dan Text Mining',
          'task': 'Tugas 1: Buat teks klasifikasi dengan judul yang ditentukan di setiap kelompok.',
          'dosen': 'Yulian Findawati, ST., M.MT.',
          'due': '2025-11-06',
          'progress': 0.1,
          'color': Colors.blue.shade600,
          'priority': 'Tugas 1',
        },
      ];

  @override
  Widget build(BuildContext context) {
    // Ambil daftar tugas dari getter
    final tasks = _tasks;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        // Background gradient hijau lembut
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade50, Colors.green.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header: tombol kembali, judul, dan jumlah tugas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Tugas Aktif',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    const Spacer(),
                    // Kotak kecil menampilkan jumlah tugas
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.list_alt, size: 16, color: Colors.green),
                          const SizedBox(width: 6),
                          Text('${tasks.length} tugas', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Dua kartu ringkasan di atas: Tugas Belum Selesai & Tenggat Terdekat
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _overviewCard(
                        icon: Icons.assignment_turned_in,
                        title: 'Tugas Belum Selesai',
                        value: '${tasks.length}',
                        color: Colors.green,
                        subtitle: 'Prioritas dan tenggat tercantum di bawah',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _overviewCard(
                        icon: Icons.schedule,
                        title: 'Tenggat Terdekat',
                        value: tasks.isNotEmpty ? tasks[2]['due'] : '-', // contoh ambil index 2
                        color: Colors.orange,
                        subtitle: 'Periksa segera',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Daftar tugas: ListView.separated agar rapi dengan jarak antar item
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: tasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final t = tasks[index];
                    return _buildTaskCard(context, t); // buat kartu tugas per item
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ringkasan kecil (overview)
  Widget _overviewCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required String subtitle,
  }) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kartu tugas utama
  Widget _buildTaskCard(BuildContext context, Map<String, dynamic> t) {
    final Color stripe = (t['color'] as Color); // warna strip samping
    final double progress = (t['progress'] as double).clamp(0.0, 1.0); // pastikan antara 0 dan 1

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Strip warna di kiri
              Container(width: 6, height: 86, decoration: BoxDecoration(color: stripe, borderRadius: BorderRadius.circular(6))),
              const SizedBox(width: 12),

              // Info tugas
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(t['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: stripe.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                      child: Text(t['priority'], style: TextStyle(fontWeight: FontWeight.bold, color: stripe)),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Text(t['task'], maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: stripe),
                      const SizedBox(width: 6),
                      Expanded(child: Text(t['dosen'], style: TextStyle(fontSize: 12, color: Colors.grey.shade700))),
                      const SizedBox(width: 8),
                      Icon(Icons.calendar_today, size: 14, color: stripe),
                      const SizedBox(width: 6),
                      Text(t['due'], style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: stripe.withOpacity(0.12),
                      valueColor: AlwaysStoppedAnimation<Color>(stripe),
                    ),
                  ),
                ]),
              ),

              const SizedBox(width: 12),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Detail tugas belum tersedia')));
                    },
                    icon: const Icon(Icons.info_outline),
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _showSubmitSheet(context, t), // buka bottom sheet untuk submit
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: stripe, width: 1.4),
                        boxShadow: [BoxShadow(color: stripe.withOpacity(0.12), blurRadius: 6, offset: Offset(0, 3))],
                      ),
                      child: Text('Submit', style: TextStyle(color: stripe, fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Menampilkan modal bottom sheet untuk submit tugas
  void _showSubmitSheet(BuildContext context, Map<String, dynamic> t) {
    final TextEditingController noteCtrl = TextEditingController(); // controller untuk input catatan

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // agar sheet bisa melebar saat keyboard muncul
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
              ),
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 48,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                      ),
                    ),

                    Text('Kirim Tugas: ${t['title']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(t['task'], style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                    const SizedBox(height: 12),

                    TextField(
                      controller: noteCtrl,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Catatan (opsional)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fitur pilih file (simulasi) — belum diaktifkan')),
                              );
                            },
                            icon: const Icon(Icons.attach_file),
                            label: const Text('Pilih file (opsional)'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(ctx).pop(); // tutup bottom sheet
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (dctx) {
                                  // Simulasi proses kirim: tunggu 2 detik, lalu tutup dialog dan tampilkan snackbar
                                  Future.delayed(const Duration(seconds: 2), () {
                                    Navigator.of(dctx).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Tugas "${t['title']}" berhasil dikirim (simulasi).')),
                                    );
                                  });
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                      child: Column(mainAxisSize: MainAxisSize.min, children: const [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 12),
                                        Text('Mengirim tugas...'),
                                      ]),
                                    ),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text('Kirim', style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Batal'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
