import 'package:flutter/material.dart';
import 'screens/specific_gym_list_page.dart'; // Import SpecificGymListPage screen.
import 'screens/splash_page.dart'; // Import SplashPage screen.
import 'screens/login_page.dart'; // Import LoginPage screen.
import 'screens/register_page.dart'; // Import RegisterPage screen.
import 'screens/main_page.dart'; // Import MainPage screen.

/// Entry point of the application.
void main() {
  runApp(const MyApp()); // Runs the MyApp widget.
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disables the debug banner in the app.
      debugShowCheckedModeBanner: false,
      // Title of the application.
      title: 'Az Canyon College',
      // Application theme configuration.
      theme: ThemeData(
        primarySwatch: Colors.green, // Green as the primary color.
        fontFamily: 'Inter Tight', // Custom font for the application.
      ),
      // The initial route to display when the app starts.
      initialRoute: '/splash',
      // Defines all the available routes in the application.
      routes: {
        '/splash': (context) =>
            const SplashPage(), // Route for the splash screen.
        '/login': (context) => const LoginPage(), // Route for the login screen.
        '/register': (context) =>
            const RegisterPage(), // Route for the register screen.
        '/main': (context) => const MainPage(), // Route for the main screen.
        '/specificGymList': (context) =>
            const SpecificGymListPage(), // Route for the specific gym list page.
      },
    );
  }
}
