import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  final String title;
  final String assetPath;
  final Function(String) onLanguageSelected;
  final VoidCallback onClose;

  const LanguageItem({
    super.key,
    required this.title,
    required this.assetPath,
    required this.onLanguageSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(assetPath),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          onTap: () {
            // onLanguageSelected(title);
            onClose();
          },
        ),
        const Divider(
          height: 1,
          indent: 75,
          endIndent: 10,
          color: Color(0xFFEEEEEE),
        ),
      ],
    );
  }
}
