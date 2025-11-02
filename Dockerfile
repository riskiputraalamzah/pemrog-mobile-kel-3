# --- STAGE 1: Build ---
# Gunakan image Flutter untuk membangun aplikasi
# Kita beri nama stage ini 'builder'
FROM fischerscode/flutter AS builder

WORKDIR /app

# Copy file pubspec dan get dependencies (ini memanfaatkan cache Docker)
COPY pubspec.yaml ./
COPY pubspec.lock ./
RUN flutter pub get

# Copy seluruh source code
COPY . .

# (Opsional) Hapus folder platform yang tidak perlu web
RUN rm -rf android ios macos windows linux || true

# Build aplikasi web dalam mode release
RUN flutter build web --release

# --- STAGE 2: Serve ---
# Gunakan image Nginx yang sangat ringan
FROM nginx:alpine

# Salin HANYA file hasil build dari stage 'builder'
# ke direktori default Nginx
COPY --from=builder /app/build/web /usr/share/nginx/html

# (PENTING!) Salin konfigurasi Nginx kustom agar routing Flutter berfungsi
# Kita akan buat file 'nginx.conf' di langkah berikutnya
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (port default Nginx)
EXPOSE 80

# Command default untuk Nginx (tidak perlu diubah, tapi jelas)
CMD ["nginx", "-g", "daemon off;"]