import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactOption extends StatelessWidget {
  const ContactOption({super.key, required this.iconPath, required this.label});

  final String iconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: SvgPicture.asset(iconPath, width: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }
}
