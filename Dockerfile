# --- STAGE 1: Build ---
FROM fischerscode/flutter AS builder

WORKDIR /app

# -----------------------------------------------------------------
# KUNCI PERBAIKANNYA ADA DI SINI:
# 1. Ganti user ke root sementara
USER root
# 2. Ganti pemilik folder /app menjadi milik user 'flutter'
RUN chown -R flutter:flutter /app
# 3. Kembalikan ke user 'flutter'
USER flutter
# -----------------------------------------------------------------

# Copy file pubspec (sebagai user 'flutter')
COPY pubspec.yaml ./

# SEKARANG 'flutter' punya izin untuk membuat pubspec.lock di /app
RUN flutter pub get

# Copy seluruh sisa source code
COPY . .

# -----------------------------------------------------------------
# KUNCI KEDUA:
# File yang baru di-copy di atas dimiliki 'root',
# jadi kita harus ganti pemiliknya lagi.
USER root
RUN chown -R flutter:flutter /app
USER flutter
# -----------------------------------------------------------------

# (Opsional) Hapus folder platform
RUN rm -rf android ios macos windows linux || true

# Build aplikasi web (sekarang 'flutter' punya izin baca/tulis)
RUN flutter build web --release

# --- STAGE 2: Serve ---
FROM nginx:alpine

COPY --from=builder /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]