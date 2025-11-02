# --- STAGE 1: Build ---
# Gunakan image Flutter untuk membangun aplikasi
# Kita beri nama stage ini 'builder'
FROM fischerscode/flutter AS builder

WORKDIR /app

# Copy file pubspec dan get dependencies
# (Kita tidak pakai pubspec.lock dari lokal)
COPY pubspec.yaml ./
RUN flutter pub get

# Copy seluruh source code
# (File .dockerignore akan dipakai di sini)
COPY . .

# -----------------------------------------------------------------
# KUNCI PERBAIKANNYA ADA DI SINI:
# 1. Ganti user ke root sementara
USER root
# 2. Ganti pemilik semua file di /app menjadi milik user 'flutter'
RUN chown -R flutter:flutter /app
# 3. Kembalikan ke user 'flutter'
USER flutter
# -----------------------------------------------------------------

# (Opsional) Hapus folder platform yang tidak perlu web
RUN rm -rf android ios macos windows linux || true

# Build aplikasi web dalam mode release
# (Sekarang 'flutter' punya izin untuk membaca/menulis semua file)
RUN flutter build web --release

# --- STAGE 2: Serve ---
# Gunakan image Nginx yang sangat ringan
FROM nginx:alpine

# Salin HANYA file hasil build dari stage 'builder'
# ke direktori default Nginx
COPY --from=builder /app/build/web /usr/share/nginx/html

# Salin konfigurasi Nginx kustom
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (port default Nginx)
EXPOSE 80

# Command default untuk Nginx
CMD ["nginx", "-g", "daemon off;"]