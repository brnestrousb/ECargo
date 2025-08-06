import 'package:ecargo_support/features/help/pages/dev_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecargo_support/features/help/pages/ticket_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TicketProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DevMenuPage(), // Arahkan ke menu pengujian
    );
  }
}
