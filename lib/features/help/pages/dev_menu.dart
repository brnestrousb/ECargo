import 'package:flutter/material.dart';
import '../others/atribusi_data.dart';
import '../others/beri_rating.dart';
import '../others/kebijakan_privasi.dart';
import '../others/ketentuan_layanan.dart';
import '../others/pilih_bahasa.dart';
import '../others/profile_edit.dart';
import 'help_home_page.dart';
class DevMenuPage extends StatelessWidget {
  const DevMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = {
      '🏠 Help Home Page': const HelpHomePage(),
      '🌐 Pilih Bahasa': const PilihBahasaPage(),
      '📱 Beri Rating': const BeriRatingPage(),
      '📃 Kebijakan Privasi': const KebijakanPrivasiPage(),
      '📑 Ketentuan Layanan': const KetentuanLayananPage(),
      '👤 Edit Profil': const ProfileEditPage(),
      '📊 Atribusi Data': const AtribusiDataPage(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('🧪 Dev Menu Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: pages.entries.map((entry) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => entry.value),
            ),
            child: Text(entry.key),
          );
        }).toList(),
      ),
    );
  }
}
