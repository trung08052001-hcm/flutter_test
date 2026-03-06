import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/widget/background_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_testt/features/dresion_page/bloc/dresion_bloc.dart';
import 'package:flutter_testt/features/dresion_page/bloc/dresion_event.dart';
import 'package:flutter_testt/features/dresion_page/bloc/dresion_state.dart';

class DresionPage extends StatelessWidget {
  const DresionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DresionBloc()..add(DresionInitialEvent()),
      child: const DresionView(),
    );
  }
}

class DresionView extends StatelessWidget {
  const DresionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DresionBloc, DresionState>(
      listener: (context, state) {
        // Xử lý state nếu cần
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 1. Hình nền toàn màn hình
            BackgroundContainer(),

            // 2. Lớp phủ mờ (giúp nội dung chính nổi bật hơn)
            Container(color: Colors.black.withOpacity(0.2)),

            // 3. Nội dung chính ở giữa
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 350,
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Hình ảnh minh họa phía trên nội dung
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/imagepage1.png',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Dinh Độc Lập",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height:
                            200, // Bạn có thể điều chỉnh chiều cao này cho phù hợp với UI
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... "
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... "
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... "
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... "
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... "
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... "
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... "
                            "Tiếng Thái: พระราชวังเอกราชไม่ใช่เพียงอาคารธรรมดา... ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Hàng nút bấm
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[800],
                            ),
                            child: const Text(
                              "Tải xuống",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.go('/home');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[800],
                            ),
                            child: const Text(
                              "Bắt đầu tour",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
