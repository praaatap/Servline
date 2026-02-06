import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/intro');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using a Notification icon as a placeholder for the logo
            // In a real app, this would be an Image.asset
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Icon(
                  Icons.notifications,
                  size: 80,
                  color: const Color(
                    0xFF5B99FF,
                  ), // Light blue similar to design
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.access_time_filled,
                    size: 24,
                    color: Color(0xFFA6C8FF), // Lighter blue accent
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Servline',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B), // Slate-800
              ),
            ),
          ],
        ),
      ),
    );
  }
}
