import 'package:acc/firebase_options.dart';
import 'package:acc/screens/admin_scan_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth.dart';
import 'screens/specific_gym_list_page.dart';
import 'screens/splash_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasData) {
          final String? email = snapshot.data?.email;
          final bool isAdmin = email == "adminscan@gmail.com";

          // ✅ User is logged in, send to MainPage with admin info
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Az Canyon College',
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'Inter Tight',
            ),
            // ✅ Use home instead of routes for MainPage
            home: MainPage(isAdmin: isAdmin),
            routes: {
              '/splash': (context) => const SplashPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/specificGymList': (context) => const SpecificGymListPage(),
              '/scan': (context) => const AdminScanPage(),
            },
          );
        } else {
          // ✅ Not logged in, show login screen
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Az Canyon College',
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'Inter Tight',
            ),
            home: const LoginPage(),
            routes: {
              '/splash': (context) => const SplashPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/specificGymList': (context) => const SpecificGymListPage(),
            },
          );
        }
      },
    );
  }
}
