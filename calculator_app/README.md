# 🧮 Neumorphic Clean Architecture Calculator App

Suatu aplikasi Kalkulator modern berdesain **Neumorphism (Soft UI)** yang dibangun dengan **Flutter** dan menerapkan prinsip **Clean Architecture (SOLID)**, manajemen state terpisah, penyimpanan riwayat lokal permanen, serta mode tema Adaptif (Dark & Light Mode).

---

## ✨ Fitur Utama (Key Features)

- 🎨 **Neumorphic Soft UI/UX Design**: Antarmuka 3D lembut yang timbul dengan animasi bayangan ganda (*dual drop shadows*) yang amples saat ditekan.
- 🌓 **Dynamic Theme Switching (Dark & Light)**: Fitur pengubah tema instan dilengkapi dengan komponen sakelar beranimasi halus dan penyimpanan permanen melalui `SharedPreferences`.
- 📜 **Calculation History Overlay**: Panel riwayat perhitungan yang meluncur dari atas dengan animasi smooth, memungkinkan pengguna melihat dan mengosongkan riwayat kalkulasi kapan saja.
- 📳 **Haptic Tactile Feedback**: Respon getaran sentuhan ringan (*haptic feedback*) saat pengguna mengklik tombol kalkulator.
- 🏗️ **Clean Architecture Pattern**: Pemisahan layer yang rapi antara **Presentation (UI & Controllers)**, **Domain (Use Cases & Entities)**, dan **Data (Datasources & Repositories)**.
- 🧹 **Strict Clean Code & Direct Commentary**: Kode terstruktur rapi dengan aturan penjelasan komentar tepat di bawah baris kode tanpa jarak, serta pemisahan 3 baris kosong antar-blok kode untuk kemudahan baca di kemudian hari.

---

## 📐 Arsitektur Proyek (Project Structure)

```text
lib/
├── core/
│   ├── calculator/
│   │   ├── calculator_engine.dart       # Logika kalkulasi matematika murni
│   │   ├── calculator_operation.dart    # Enum operasi matematika (+, -, *, /)
│   │   └── calculator_state.dart        # Model state internal kalkulator
│   ├── constants/
│   │   └── app_colors.dart             # Palette warna Neumorphism
│   └── utils/
│       └── haptic_utils.dart           # Helper getaran sentuhan haptic
├── data/
│   ├── datasources/
│   │   └── local/
│   │       └── shared_preferences_datasource.dart  # Penyimpanan lokal SharedPreferences
│   ├── models/
│   │   └── calculation_model.dart      # Data Model seriabel JSON
│   └── repositories/
│       └── calculation_repository.dart # Implementasi repository riwayat
├── domain/
│   ├── entities/
│   │   └── calculation_entity.dart     # Entitas domain riwayat perhitungan
│   ├── repositories/
│   │   └── i_calculation_repository.dart # Kontrak antarmuka repository
│   └── usecases/
│       ├── add_calculation_usecase.dart
│       ├── get_calculation_history_usecase.dart
│       └── clear_calculation_history_usecase.dart
├── presentation/
│   ├── controllers/
│   │   └── calculator_controller.dart  # ChangeNotifier State Management
│   ├── pages/
│   │   └── calculator_page.dart        # Halaman utama kalkulator & layout overlay
│   ├── themes/
│   │   └── app_theme.dart              # Konfigurasi tema terang & gelap
│   └── widgets/
│       ├── calculator_display.dart     # Layar output ekspresi & angka
│       ├── calculator_keypad.dart      # Grid tombol kalkulator responsif
│       ├── history_panel.dart          # Sheet overlay riwayat transaksi
│       ├── neumorphic_button.dart      # Tombol 3D kustom Neumorphism
│       └── theme_toggle_switch.dart    # Sakelar pengubah tema beranimasi
└── main.dart                            # Entri poin utama aplikasi
```

---

## 📝 Aturan Penulisan Kode & Komentar (Clean Code Standard)

Aplikasi ini menggunakan aturan format kode dan komentar khusus:
1. **Baris Kode di Atas, Penjelasan Komentar di Bawah**: Komentar diletakkan tepat di bawah blok kode tanpa ada jarak baris (*zero vertical space*).
2. **Pemisah 3 Baris Kosong**: Setiap pasangan (Kode + Komentar Penjelasan) dipisahkan oleh 3 baris kosong dari blok kode selanjutnya.
3. **Bahasa Indonesia yang Ramah Pemula**: Seluruh komentar penjelasan UI/UX menggunakan Bahasa Indonesia yang ringkas dan mudah dipahami untuk pembacaan jangka panjang.

---

## 🚀 Cara Menjalankan Aplikasi (Getting Started)

### Prasyarat:
- Flutter SDK (v3.0.0 atau yang lebih baru)
- Dart SDK
- Android Studio / VS Code

### Langkah-langkah:
1. **Clone repository ini**:
   ```bash
   git clone https://github.com/username/calculator_app.git
   cd calculator_app
   ```

2. **Dapatkan dependensi**:
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**:
   ```bash
   flutter run
   ```

---

## 💼 Caption LinkedIn Ready to Share

Berikut adalah caption LinkedIn yang disiapkan khusus dan siap untuk dipublikasikan:

```markdown
🚀 Exciting Project Update: Building a Modern Neumorphic Calculator App with Flutter & Clean Architecture! 🧮✨

Saya baru saja menyelesaikan refactoring & pengembangan aplikasi Kalkulator berbasis Flutter dengan desain **Neumorphism (Soft UI)** yang modern, responsif, dan kaya akan fitur interaktif! 📱💻

🎯 **Fitur Utama & Keunggulan Proyek:**
🔹 **Neumorphic Soft UI/UX**: Tampilan 3D elegan dengan bayangan ganda dinamis (dual drop shadow) yang memberikan efek umpan balik tombol tertekan yang nyata.
🔹 **Adaptive Dark & Light Mode**: Pemilih tema dengan sakelar beranimasi halus dan penyimpanan preferensi lokal secara permanen.
🔹 **Persistent History Layer**: Panel riwayat perhitungan meluncur (sliding overlay) yang menyimpan kalkulasi matematika sebelumnya menggunakan `SharedPreferences`.
🔹 **Clean Architecture Pattern**: Pemisahan layer Presentation, Domain (UseCases), dan Data untuk kode yang modular, scalable, dan muat diuji (*testable code*).
🔹 **Strict Clean Code & Readable Comments**: Penerapan aturan komentar di bawah kode dan 3-baris spacing antar-blok kode dalam Bahasa Indonesia yang sangat ramah pemula dan mudah dibaca di kemudian hari.

💡 Proyek ini memperkuat pemahaman saya dalam manajemen state Flutter (`ChangeNotifier`), custom UI painting & animation, serta penerapan prinsip-prinsip SOLID pada aplikasi mobile.

Bagaimana pendapat Anda mengenai desain Neumorphism pada aplikasi mobile modern saat ini? Saya sangat terbuka untuk diskusi dan masukkan konstruktif! 👇

#Flutter #FlutterDev #Dart #CleanArchitecture #MobileAppDevelopment #UIUXDesign #Neumorphism #SoftwareEngineering #OpenSource #MobileDeveloper #LinkedInCommunity
```

---

*Dibuat dengan ❤️ menggunakan Flutter & Clean Code Standards.*
