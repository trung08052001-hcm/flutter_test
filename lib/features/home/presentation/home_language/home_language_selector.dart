import 'package:flutter/material.dart';
import 'package:flutter_testt/widget/build_item.dart';

class HomeLanguageSelector extends StatelessWidget {
  final VoidCallback onClose;
  final Function(String) onLanguageSelected;

  final List<Map<String, String>> languages = [
    {'name': 'Chinese', 'flag': 'assets/flags/china.png'},
    {'name': 'English', 'flag': 'assets/flags/uk.png'},
    {'name': 'French', 'flag': 'assets/flags/france.png'},
    {'name': 'German', 'flag': 'assets/flags/germany.png'},
    {'name': 'VietNam', 'flag': 'assets/flags/vietnam.png'},
  ];

  HomeLanguageSelector({
    super.key,
    required this.onClose,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Chọn ngôn ngữ", // Hoặc "เลือกภาษา"
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: languages.map((lang) {
                  return LanguageItem(
                    title: lang['name']!,
                    assetPath: lang['flag']!,
                    onLanguageSelected: onLanguageSelected,
                    onClose: onClose,
                  );
                }).toList(),
              ),
            ),
          ),

          // Duyệt qua danh sách languages để tạo UI tự động
          const Divider(height: 1),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
