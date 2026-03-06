import 'package:go_router/go_router.dart';
import 'package:flutter_testt/features/splash/presentation/splash_page.dart';
import 'package:flutter_testt/features/home/home_page.dart';
import 'package:flutter_testt/features/dresion_page/presentation/dresion_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/dresion',
      name: 'dresion',
      builder: (context, state) => const DresionPage(),
    ),
  ],
);
