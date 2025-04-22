import 'package:flutter/material.dart';

//---------------------------------------------------------
//          SPLASH SCREEN
//---------------------------------------------------------
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds before navigating to the LoginPage.
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
          context, '/login'); // Replaces the current page with LoginPage.
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Sets the background color of the splash screen.
      backgroundColor: Color(0xFF2D7815), // Dark green color.
      // Centered content in the splash screen.
      body: Center(
        child: Text(
          'Az Canyon College', // App title or branding text.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the text.
            fontSize: 36, // Large font size for visibility.
            fontWeight: FontWeight.bold, // Bold font style for emphasis.
            color: Colors
                .white, // White text color to contrast with the background.
          ),
        ),
      ),
    );
  }
}
