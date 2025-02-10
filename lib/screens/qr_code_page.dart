import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// A stateless widget representing the QR Code page.
class QRCodePage extends StatelessWidget {
  const QRCodePage({super.key});

  // Getting users details for QR Code
  Future<String> fetchUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

    User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      DatabaseReference userRef = dbRef.child("users").child(uid);

      try {
        final event = await userRef.once();
        if (event.snapshot.exists) {
          Map<dynamic, dynamic>? userData =
              event.snapshot.value as Map<dynamic, dynamic>?;

          if (userData != null) {
            String firstName = userData['firstName'] ?? "Unknown";
            String lastName = userData['lastName'] ?? "Unknown";
            String email = userData['email'] ?? "No Email";

            // Format the QR code data string
            return "Name: $firstName $lastName\nEmail: $email";
          }
        }
        return "User data not found";
      } catch (e) {
        return "Error fetching data";
      }
    } else {
      return "User not logged in";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the structure for the page.
      appBar: AppBar(
        // Sets the background color of the AppBar.
        backgroundColor: const Color(0xFF2D7815), // Dark green color.
        // Centers the title text in the AppBar.
        centerTitle: true,
        // Adds a slight shadow to the AppBar.
        elevation: 2,
        // Title of the AppBar.
        title: const Text(
          'Az Canyon College', // Displays the page title.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the title.
            fontSize: 22, // Font size for the title.
            color: Colors.white, // White text color.
          ),
        ),
      ),
      // SafeArea ensures the content avoids system UI overlays (e.g., notches).
      body: SafeArea(
        // Column stacks widgets vertically.
        child: FutureBuilder<String>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text("Error fetching QR Code data"));
            }

            String qrData = snapshot.data ?? "No data available";

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 291,
                    height: 375,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: QrImageView(
                        data: qrData,
                        version: QrVersions.auto,
                        size: 250.0,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
