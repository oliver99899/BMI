import 'package:flutter/material.dart';
import 'screens/menu_screen.dart'; // Import halaman menu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Pro',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MenuScreen(),
    );
  }
}