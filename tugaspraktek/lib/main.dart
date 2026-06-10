import 'package:flutter/material.dart';
import 'screens/carmarketscreen.dart'; 
void main() {
  runApp(const DriveVerseApp());
}

class DriveVerseApp extends StatelessWidget {
  const DriveVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drive-Verse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F172A), 
        primaryColor: const Color(0xFF3B82F6), 
        fontFamily: 'Roboto',
      ),
      home: const CarMarketplaceScreen(), 
    );
  }
}