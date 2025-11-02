# Gunakan base image Flutter
FROM fischerscode/flutter

# Set direktori kerja
WORKDIR /app

# Salin hanya file yang diperlukan untuk install dependency
COPY pubspec.yaml ./
RUN flutter pub get

# Salin seluruh kode proyek
COPY . .

# Jalankan sebagai root sementara untuk hapus folder Android/iOS
USER root
RUN rm -rf android ios || true

# Pastikan direktori bisa ditulis
RUN chmod -R 777 /app

# Kembalikan user default ke non-root (lebih aman)
USER flutter

# Build Flutter Web (release mode)
RUN flutter build web --release

# Jalankan Flutter web server
CMD ["flutter", "run", "-d", "web-server", "--web-port=8080", "--web-hostname=0.0.0.0"]