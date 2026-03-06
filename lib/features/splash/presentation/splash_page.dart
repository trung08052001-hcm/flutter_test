import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/widget/background_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_testt/features/splash/bloc/splash_bloc.dart';
import 'package:flutter_testt/features/splash/bloc/splash_event.dart';
import 'package:flutter_testt/features/splash/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(StartSplashEvent()),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.completed) {
          // Navigate to dresion page after button pressed
          context.go('/dresion');
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 1. Hình nền toàn màn hình
            BackgroundContainer(),

            // 2. Lớp phủ làm mờ
            Container(color: Colors.black.withOpacity(0.1)),

            // 3. Phần nội dung App "lơ lửng" ở giữa
            Center(
              child: Container(
                width: 300,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // Logo placeholder
                    Container(
                      height: 80,
                      width: 150,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Text(
                          'GUIDE APP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Hình ảnh Dinh Độc Lập phía dưới
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Container(
                            height: 200,
                            width: 300,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/imagepage1.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        // Nút tròn màu đỏ có mũi tên
                        Positioned(
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              context.read<SplashBloc>().add(
                                NavigateToDresionEvent(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
