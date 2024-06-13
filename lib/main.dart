import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF4EDDB),
          primary: const Color(0xFFE7626C),
          onPrimary: const Color(0xFFF4EDDB),
          secondary: const Color(0xff232B55),
          onSecondary: const Color(0xFFF4EDDB),
          onSurface: const Color(0xff232B55),
          // surface: const Color(0xFFF4EDDB),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
