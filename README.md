# 🚚 E-Cargo Support Page

Halaman bantuan (Help Page) untuk aplikasi **E-Cargo**, dirancang menggunakan Flutter. Menyediakan fitur kategori bantuan, Generate code, Chat Page
---

## 📱 Fitur Utama

- 📂 **Kategori Bantuan:** Menampilkan berbagai kategori bantuan secara visual dengan kartu UI interaktif.
- 📞 **Opsi Kontak:** WhatsApp, Email, dan Telepon terintegrasi langsung dengan perangkat pengguna.
- 🎨 **UI Kustom:** Menggunakan custom clipper untuk tampilan header dinamis.
- 🌐 **Responsif:** Siap untuk digunakan pada berbagai ukuran layar mobile.

---

## 🏗️ Tools

- [✔️] **Flutter** (Dart)
- [✔️] Custom Clipper (untuk dekorasi UI)
- [✔️] SVG Asset Handling via `flutter_svg`
- [✔️] Use Shared Preferences via `shared_preferences`
- [✔️] Clean Widget Composition

---

## 📁 Struktur Folder

```plaintext
lib/
├── features/
│   └── help/                    
|       ├── clippers/header_curve_clipper.dart               
│       ├── pages/  
|       |   └── help_chat_page.dart         #Template Page untuk Chat CS
|       |   └── help_detail_page.dart       #Template Detail untuk Question
|       |   └── help_home_page.dart         #Titik Utama 
|       |   └── hub_page.dart               #Untuk Code Generator
|       |   └── ticket_provider.dart        #Untuk sinkronisasi persistensi data
│       └── widgets/ 
|           └── contact_option.dart
|           └── help_category.dart        
│
└── main.dart                      

