import 'package:flutter/material.dart';
import '../widgets/contact_option.dart';
import '../widgets/help_category_card.dart';

class HelpHomePage extends StatelessWidget {
  const HelpHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF007BFF), Color(0xFF0056D2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Bagaimana kami bisa membantu anda?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20), //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ContactOption(
                        iconPath: 'assets/icons/call.svg',
                        label: 'Hubungi\nKami',
                      ),
                      ContactOption(
                        iconPath: 'assets/icons/whatsapp.svg',
                        label: 'Whatsapp',
                      ),
                      ContactOption(
                        iconPath: 'assets/icons/history.svg',
                        label: 'Riwayat\nBantuan',
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Too Many Arguments
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Cari Masalah Anda..",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: const [
                          HelpCategoryCard(
                            icon: Icons.local_shipping,
                            title: 'Pengiriman',
                            question: [
                              'Bagaimana cara melacak status pengiriman saya?',
                              'Bagaimana estimasi waktu pengiriman?',
                              'Apakah bisa mengganti alamat pengiriman setelah transaksi?',
                            ],
                          ),
                          HelpCategoryCard(
                            icon: Icons.gavel,
                            title: 'Lelang',
                            question: [
                              'Bagaimana cara mengikuti lelang?',
                              'Apa saja syarat mengikuti lelang?',
                              'Apakah lelang bersifat real-time?',
                            ],
                          ),
                          HelpCategoryCard(
                            icon: Icons.receipt_long,
                            title: 'Transaksi',
                            question: [
                              'Bagaimana cara melihat riwayat transaksi?',
                              'Apakah saya bisa membatalkan transaksi?',
                              'Bagaimana jika pembayaran gagal?',
                            ],
                          ),
                          HelpCategoryCard(
                            icon: Icons.delivery_dining,
                            title: 'Kurir',
                            question: [
                              'Bagaimana memilih kurir saat checkout?',
                              'Kurir tidak datang, apa yang harus saya lakukan?',
                              'Apakah bisa menjadwalkan ulang pengiriman?',
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
