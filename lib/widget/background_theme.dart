import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget? child; // Cho phép truyền thêm nội dung vào bên trong

  const BackgroundContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fullimage.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
