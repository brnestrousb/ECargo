// lib/features/help/widgets/support_detail_body.dart
import 'package:flutter/material.dart';
import '../models/support_model.dart';

class SupportDetailBody extends StatelessWidget {
  final SupportDetailContent content;

  const SupportDetailBody({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            content.question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(content.introText),
          const SizedBox(height: 16),
          ...content.steps.map(
            (step) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(step.description),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (content.statuses.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Status yang biasanya ditampilkan:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ...content.statuses
                    .map((status) => Text("• $status"))
              ],
            ),
          const SizedBox(height: 16),
          Text(content.footerNote),
        ],
      ),
    );
  }
}
