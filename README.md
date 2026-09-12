<!-- Fitur Utama -->
| Fitur                         | Keterangan                                                               |
|-------------------------------|--------------------------------------------------------------------------|
| **Screen 1 — Beranda**        | `StatelessWidget` · Menampilkan 3 card paket layanan IT dalam `ListView` |
| **Screen 2 — Detail Katalog** | `StatefulWidget` · Detail lengkap paket dengan tombol interaktif         |
| **Stack Navigation**          | Perpindahan Screen menggunakan `Navigator.push` & `Navigator.pop`        |
| **Tombol Favorit**            | Toggle state `_isFavorite` dengan `setState()` di AppBar                 |
| **Tombol Pesan**              | Toggle state `_isOrdered` dengan `setState()` + SnackBar konfirmasi      |


<!-- Struktur Proyek -->
lib/
├── main.dart                    # Entry point, MaterialApp → BerandaScreen
├── screens/
│   ├── beranda_screen.dart      # Screen 1: Katalog (StatelessWidget + ListView)
│   └── detail_screen.dart      # Screen 2: Detail Katalog (StatefulWidget)
└── widgets/
    └── pricing_card.dart        # Reusable card komponen (desain tidak diubah)


<!-- Setup project & Cara Menjalankan server lokal -->
## Prasyarat
- [Flutter SDK](https://docs.flutter.dev/get-started/install) versi **3.13.0** ke atas
- [Visual Studio Code](https://code.visualstudio.com/) (disertai ekstensi Flutter & Dart)
- [Android Studio](https://developer.android.com/studio) (digunakan untuk Virtual Device Manager / Android Emulator)

## Langkah-langkah

**1. Menyalakan Emulator Android via Android Studio**
- Buka aplikasi **Android Studio**.
- Pada halaman awal (*Welcome to Android Studio*), klik menu **More Actions** (ikon titik tiga atau tombol More Actions).
- Pilih **Virtual Device Manager** (atau **Device Manager**).
- Cari perangkat emulator yang tersedia (misalnya *Pixel / Phone API 34*), lalu klik tombol **Launch / Run (▶️)**.
- Tunggu hingga emulator Android menyala dan menampilkan layar beranda (home screen). Jendela Android Studio bisa diminimize setelah emulator aktif.

**2. Setup Project di VS Code**
- Buka **Visual Studio Code**.
- Buka folder proyek ini (`mobile-case`) melalui menu **File** > **Open Folder...**.
- Buka Terminal di VS Code (`Ctrl + \`` atau menu **Terminal** > **New Terminal**).
- Jalankan perintah berikut untuk mengunduh seluruh dependensi:
  ```bash
  flutter pub get
  ```

**3. Menjalankan Aplikasi dari VS Code**
- Pastikan emulator Android yang aktif sudah terdeteksi di status bar pojok kanan bawah VS Code (atau tekan `Ctrl + Shift + P` lalu pilih **Flutter: Select Device**).
- Jalankan aplikasi dengan salah satu cara berikut:
  - Tekan tombol **F5** (atau menu **Run** > **Start Debugging** / **Run Without Debugging**), **atau**
  - Jalankan perintah berikut di Terminal VS Code:
    ```bash
    flutter run
    ```
- Tunggu proses build selesai hingga aplikasi otomatis terbuka di emulator Android.
- Saat melakukan perubahan kode, gunakan fitur **Hot Reload** (tekan `r` pada terminal atau ikon petir ⚡ pada debug toolbar) untuk melihat perubahan secara instan.

**4. Build APK (opsional)**
Jalankan perintah berikut di terminal VS Code jika ingin membuat file installer APK:
```bash
flutter build apk --release
```

 <!-- Alur Navigasi -->
BerandaScreen (Screen 1)
│
│  Klik card / ListTile / tombol "Pilih Paket"
│  → Navigator.push (menambah route ke Stack)
│
▼
DetailScreen (Screen 2)
│
│  Klik tombol "Kembali ke Beranda" atau ikon ← di AppBar
│  → Navigator.pop (menghapus route dari Stack)
│
▼
BerandaScreen (Screen 1) ← kembali ke sini
```


```
<!-- Konsep yang Diimplementasikan -->

## Routing & Navigation
- **Direct Routes** — menggunakan `MaterialPageRoute` langsung di `Navigator.push`
- **Screen Removal** — menggunakan `Navigator.pop` untuk kembali ke Screen sebelumnya
- **Passing Data** — data paket (nama, harga, fitur, dll.) dikirim via constructor `DetailScreen`

## Navigator Stack
```
[Awal]     Stack: [ BerandaScreen ]
[push]     Stack: [ BerandaScreen | DetailScreen ]  ← user melihat Detail
[pop]      Stack: [ BerandaScreen ]                 ← user kembali ke Beranda
```

## StatelessWidget vs StatefulWidget
| Widget             | Screen | Alasan                                                       |
|--------------------|--------|--------------------------------------------------------------|
| `StatelessWidget`  | Beranda| Data statis, tidak ada perubahan state                       |
| `StatefulWidget`   | Detail | Ada perubahan state interaktif (`_isFavorite`, `_isOrdered`) |

---

## Catatan
- Aplikasi ini **tidak menggunakan database MySQL** 
- Data paket layanan IT bersifat statis 
- aplikasi berjalan sepenuhnya secara lokal (di perangkat/emulator) 


<!-- Panduan Import Database MySQL (`mobile_case`) -->
Jika proyek membutuhkan import file database MySQL (misalnya `database.sql` atau `mobile_case.sql`), ikuti salah satu cara berikut:
## Opsi 1: Menggunakan phpMyAdmin (XAMPP / Laragon)
1. **Nyalakan Layanan MySQL**:
   - Buka aplikasi **XAMPP** atau **Laragon**.
   - Klik tombol **Start** pada modul **Apache** dan **MySQL**.
2. **Buka phpMyAdmin**:
   - Buka browser dan kunjungi `http://localhost/phpmyadmin`.
3. **Buat Database Baru**:
   - Klik menu **New** (Baru) di sidebar sebelah kiri.
   - Masukkan nama database: `mobile_case` (atau `` `mobile-case` ``).
   - Klik tombol **Create**.
4. **Import File SQL**:
   - Klik database `mobile_case` yang baru dibuat.
   - Pilih tab **Import** di menu navigasi atas.
   - Klik **Choose File** / **Pilih Berkas**, lalu pilih file `.sql` Anda (misalnya file SQL di folder proyek `mobile-case`).
   - Gulir ke bawah dan klik tombol **Import** / **Kirim**.
   - Tunggu hingga muncul notifikasi sukses berwarna hijau.
---
## Opsi 2: Menggunakan Terminal / Command Prompt (CLI)
1. Buka Terminal / CMD di folder proyek `mobile-case`.
2. Buat database terlebih dahulu:
   ```bash
   mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS mobile_case;"
   ```
3. Import file SQL ke dalam database:
   ```bash
   mysql -u root -p mobile_case < database.sql
   ```
   *(Tekan `Enter` jika menggunakan konfigurasi default tanpa password).*