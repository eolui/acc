import 'package:acc/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'services/auth.dart'; // Import AuthService
import 'screens/specific_gym_list_page.dart'; // Import SpecificGymListPage screen.
import 'screens/splash_page.dart'; // Import SplashPage screen.
import 'screens/login_page.dart'; // Import LoginPage screen.
import 'screens/register_page.dart'; // Import RegisterPage screen.
import 'screens/main_page.dart'; // Import MainPage screen.

/// Entry point of the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // Runs the MyApp widget.
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Listen for changes in the user's authentication state
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the auth state
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasData) {
          // If the user is logged in, go to the main screen
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Az Canyon College',
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'Inter Tight',
            ),
            initialRoute: '/main',
            routes: {
              '/splash': (context) => const SplashPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/main': (context) => const MainPage(),
              '/specificGymList': (context) => const SpecificGymListPage(),
            },
          );
        } else {
          // If the user is not logged in, go to the login screen
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Az Canyon College',
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'Inter Tight',
            ),
            initialRoute: '/login',
            routes: {
              '/splash': (context) => const SplashPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/main': (context) => const MainPage(),
              '/specificGymList': (context) => const SpecificGymListPage(),
            },
          );
        }
      },
    );
  }
}
