import 'package:ecargo_support/features/help/clippers/header_curve_clipper.dart';
import 'package:ecargo_support/features/help/models/support_model.dart';
import 'package:ecargo_support/features/help/pages/help_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/contact_option.dart';
import '../widgets/help_category_card.dart';

class HelpHomePage extends StatelessWidget {
  const HelpHomePage({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final List<HelpCategoryCard> helpCategories = [
      HelpCategoryCard(
        icon: SvgPicture.asset(
          'assets/icons/pengiriman.svg',
          width: 1.5,
          height: 1.5,
        ),
        title: 'Pengiriman',
        question: [
          'Bagaimana cara melacak status pengiriman saya?',
          'Berapa lama estimasi waktu pengiriman?',
          'Bagaimana jika barang saya belum sampai padahal status sudah terkirim?',
          'Apakah saya bisa mengganti alamat pengiriman setelah pembayaran?',
          'Apa yang terjadi jika kurir tidak menemukan alamat saya?',
          'Apakah saya bisa memilih kurir sendiri?',
          'Bagaimana cara mengklaim barang yang rusak saat diterima?',
        ],
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SupportDetailPage(
                content: SupportDetailContent(
                  question: 'Bagaimana cara melacak status pengiriman saya?',
                  introText: '''
                  Setelah Anda melakukan pembayaran dan pesanan berhasil dikonfirmasi, 
                  sistem akan otomatis mengirimkan nomor resi (tracking number) melalui halaman Transaksi Anda.
                  ''',
                  steps: [
                    SupportStep(title: 'Masuk ke menu "Transaksi"', description: ''' 
                    Temukan pesanan yang ingin Anda lacak di daftar pesanan Anda.
                    '''),
                    SupportStep(title: 'Klik pada detail ...', description: '''
                     Anda akan melihat informasi lengkap mengenai status pemesanan, termasuk status pengiriman dan nomor resi.
                    '''),
                    SupportStep(title: 'Gunakan nomor resi untuk pelacakan real-time', description: '''
                    Beberapa sistem memungkinkan Anda melacak langsung dari aplikasi, 
                    sementara lainnya menyediakan tautan ke situs resmi kurir untuk melihat perjalanan paket secara lebih detail.
                    '''),
                  ],
                  statuses: [
                    'Paket sedang dikemas',
                    'Paket sudah diambil kurir',
                    'Dalam perjalanan',
                    'Sedang dikirim',
                    'Telah diterima',
                  ],
                  footerNote:
                      'Jika status tidak berubah dalam waktu lama, ...',
                ),
              ),
            ),
          );
        }
      ),
      HelpCategoryCard(
        icon: SvgPicture.asset(
          'assets/icons/lelang.svg',
          width: 1.5,
          height: 1.5,
        ),
        title: 'Lelang',
        question: [
          'Bagaimana cara mengikuti lelang?',
          'Apakah ada deposit untuk lelang?',
          'Bagaimana jika saya memenangkan lelang?',
        ],
        onTap: (){},
      ),
      HelpCategoryCard(
        icon: SvgPicture.asset(
          'assets/icons/transaksi.svg',
          width: 1.5,
          height: 1.5,
        ),
        title: 'Transaksi',
        question: [
          'Bagaimana cara melihat riwayat transaksi?',
          'Apa yang harus dilakukan jika pembayaran gagal?',
        ],
        onTap: (){},
      ),
      HelpCategoryCard(
        icon: SvgPicture.asset(
          'assets/icons/kurir.svg',
          width: 1.5,
          height: 1.5,
        ),
        title: 'Kurir',
        question: [
          'Kurir mana saja yang tersedia?',
          'Bagaimana cara menghubungi kurir?',
        ],
        onTap: (){},
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: HeaderCurveClipper(),
              child: Container(
                width: double.infinity,
                height: 400,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF007BFF), Color(0xFF0056D2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 41,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(10),
                                spreadRadius: 8,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/arrow_back.svg',
                              width: 15,
                              height: 15,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ContactOption(
                            iconPath: 'assets/icons/call.svg',
                            label: 'Hubungi\nKami',
                            onTap: () {                         
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SupportDetailPage(), //Expected an identifier
                                ),
                               );
                            },
                          ),
                        ),
                        Expanded(
                          child: ContactOption(
                            iconPath: 'assets/icons/whatsapp.svg',
                            label: 'Whatsapp',
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: ContactOption(
                            iconPath: 'assets/icons/history.svg',
                            label: 'Riwayat\nBantuan',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F8F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  itemCount: helpCategories.length,
                  itemBuilder: (context, index) {
                    final category = helpCategories[index];
                    return HelpCategoryCard(
                      icon: category.icon,
                      title: category.title,
                      question: category.question, 
                      onTap: category.onTap,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
