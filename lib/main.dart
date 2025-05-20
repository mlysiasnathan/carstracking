import 'package:flutter/material.dart';
import 'package:nrep/providers/theme.dart';
import 'package:provider/provider.dart';
import 'providers/car_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider()..getIn(),
        ),
        ChangeNotifierProvider(
          create: (_) => CarProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Cars Tracking',
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.themeMode,
          locale: themeProvider.locale,
          home: const HomeScreen(),
        );
      },
    );
  }
}
