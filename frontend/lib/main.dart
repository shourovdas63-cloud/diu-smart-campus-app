import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'providers/profile_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('settingsBox');
  await Hive.openBox('profileBox');

  final themeProvider = ThemeProvider();
  themeProvider.loadFromHive();

  final profileProvider = ProfileProvider();
  profileProvider.loadFromHive();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeProvider),
        ChangeNotifierProvider(create: (_) => profileProvider),
      ],
      child: const DIUSmartCampusApp(),
    ),
  );
}

class DIUSmartCampusApp extends StatelessWidget {
  const DIUSmartCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DIU Smart Campus',
      themeMode: themeProvider.darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(themeProvider.textScale),
          ),
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}
