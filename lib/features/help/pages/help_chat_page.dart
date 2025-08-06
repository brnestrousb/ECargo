import 'package:ecargo_support/features/help/pages/help_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpChatPage extends StatelessWidget {
  final String? ticketNumber;

  const HelpChatPage({super.key, this.ticketNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HelpHomePage())),
        ),
        title: Text('No. Bantuan: $ticketNumber'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: ticketNumber!));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nomor bantuan disalin')),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Chat dimulai di sini..."),
      ),
    );
  }
}
