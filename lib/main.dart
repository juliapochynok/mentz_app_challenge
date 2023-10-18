import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentz_app_challenge/presentation/app_theme.dart';
import 'package:mentz_app_challenge/presentation/bloc/home_screen_bloc.dart';
import 'package:mentz_app_challenge/presentation/home_screen.dart';

import 'data/storage/storage.dart';

SharedPrefsLocalStorage sharedPrefsLocalStorage = SharedPrefsLocalStorage();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'App Challenge',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.defaultTheme,
            home: BlocProvider<HomeScreenBloc>(
              create: (context) => HomeScreenBloc(),
              child: const MyHomePage(title: 'Plan your journey'),
            ),
          );
        });
  }
}
