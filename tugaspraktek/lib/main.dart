import 'package:flutter/material.dart';
import 'screens/carmarketscreen.dart'; 
void main() {
  runApp(const MobilBekas());
}

class MobilBekas extends StatelessWidget {
  const MobilBekas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobil Bekas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F172A), 
        primaryColor: const Color(0xFF3B82F6), 
        fontFamily: 'Roboto',
      ),
      home: const CarMarketplace(), 
    );
  }
}