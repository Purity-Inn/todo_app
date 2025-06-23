import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  Future<bool> _checkOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seen_onboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system, // Use system default
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _checkOnboardingSeen(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();
          return snapshot.data! ? HomeScreen() : OnboardingScreen();
        },
      ),
    );
  }
}
