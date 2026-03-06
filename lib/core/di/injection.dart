import 'package:flutter_testt/features/dresion_page/bloc/dresion_bloc.dart';
import 'package:flutter_testt/features/splash/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_testt/features/counter/counter.dart';

import 'package:flutter_testt/features/home/home.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register BLoCs
  getIt.registerFactory<CounterBloc>(() => CounterBloc());
  getIt.registerFactory<SplashBloc>(() => SplashBloc());
  getIt.registerFactory<DresionBloc>(() => DresionBloc());
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
}
