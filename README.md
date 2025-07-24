# 🚚 E-Cargo Support Page

Halaman bantuan (Help Page) untuk aplikasi **E-Cargo**, dirancang menggunakan Flutter. Menyediakan fitur kategori bantuan, opsi kontak, dan tampilan UI dinamis berbasis dekorasi kustom.

---

## 📱 Fitur Utama

- 📂 **Kategori Bantuan:** Menampilkan berbagai kategori bantuan secara visual dengan kartu UI interaktif.
- 📞 **Opsi Kontak:** WhatsApp, Email, dan Telepon terintegrasi langsung dengan perangkat pengguna.
- 🎨 **UI Kustom:** Menggunakan custom clipper untuk tampilan header dinamis.
- 🌐 **Responsif:** Siap untuk digunakan pada berbagai ukuran layar mobile.

---

## 🏗️ Teknologi & Tools

- [✔️] **Flutter** (Dart)
- [✔️] Custom Clipper (untuk dekorasi UI)
- [✔️] SVG Asset Handling via `flutter_svg`
- [✔️] Clean Widget Composition

---

## 📁 Struktur Folder

```plaintext
lib/
│
├── features/
│   └── help/
│       ├── clippers/              # Custom clipper untuk header UI
│       ├── widgets/               # Komponen UI reusable seperti ContactOption dan HelpCategoryCard
│       └── help_home_page.dart    # Entry point untuk halaman bantuan
│
└── main.dart
