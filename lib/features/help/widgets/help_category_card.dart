import 'package:flutter/material.dart';

class HelpCategoryCard extends StatelessWidget {
  const HelpCategoryCard({super.key, required this.icon, required this.title, required List question});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        children: [],
      ),
    );
  }
}
