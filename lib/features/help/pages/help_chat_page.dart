import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpChatPage extends StatelessWidget {
  final String ticketNumber;

  const HelpChatPage({super.key, required this.ticketNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No. Bantuan: $ticketNumber'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: ticketNumber));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nomor bantuan disalin')),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Chat dimulai di sini..."),
      ),
    );
  }
}
