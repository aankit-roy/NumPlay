import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'const/app_theme.dart';
import 'models/board_adapter.dart';

import 'game.dart';

void main() async {
  //Allow only portrait mode on Android & iOS
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  //Make sure Hive is initialized first and only after register the adapter.
  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Set your design size
      minTextAdapt: true, // Ensures text scales properly
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NumPlay',
          theme: AppTheme.lightTheme(context),
          // Light theme
          darkTheme: AppTheme.darkTheme(context),
          // Dark theme
          themeMode: ThemeMode.light,
          home: const Game(),
          // home: const HomeScreen() // Replace with your homepage widget
          // home: const DiscoverBookScreen(),
          // home: const SearchBarScreen(),
        );
      },
    );
  }
}
