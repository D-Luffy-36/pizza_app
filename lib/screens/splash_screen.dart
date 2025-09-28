import 'package:flutter/material.dart';
import 'package:pizza_app/screens/screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2937),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 24),
            _buildTitle(),
            const SizedBox(height: 12),
            _buildSubtitle(),
            const SizedBox(height: 32),
            _buildLoading(),
            const SizedBox(height: 40),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  // Logo
  Widget _buildLogo() {
    return const Icon(
      Icons.local_pizza,
      size: 100,
      color: Colors.white,
    );
  }

  // Title
  Widget _buildTitle() {
    return const Text(
      "Ứng dụng Pizza",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    );
  }

  // Subtitle
  Widget _buildSubtitle() {
    return const Text(
      "Đang khởi động...",
      style: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    );
  }

  // Loading indicator
  Widget _buildLoading() {
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 2.5,
    );
  }

  // Next button
  Widget _buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        "Next",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
