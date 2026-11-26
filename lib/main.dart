import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';
import 'pages/home_ui.dart';

void main() {
  runApp(const TaxiFareApp());
}

class TaxiFareApp extends StatelessWidget {
  const TaxiFareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Fare Calculator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.taxiTheme,
      home: const SplashScreenUI(),
    );
  }
}

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeUI()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryYellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/taxi_image.jpg', height: 150, fit: BoxFit.contain),
            const SizedBox(height: 20),
            const Text(
              "Taxi Fare",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
