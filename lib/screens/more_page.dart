import 'package:acc/screens/login_page.dart';
import 'package:acc/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//--------------------------------------------------------
//                MORE PAGE
//--------------------------------------------------------
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  // Gets current user first and last name
  Future<Map<String, String>> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child("users").child(user.uid);

        DatabaseEvent event = await userRef.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          Map<dynamic, dynamic> userData =
              snapshot.value as Map<dynamic, dynamic>;

          return {
            "firstName": userData["firstName"] ?? "Unknown",
            "lastName": userData["lastName"] ?? "Unknown",
          };
        }
      }
    } catch (e) {
      // Return error if can't get user's first and last name
      print("Error fetching user data: $e");
    }
    // Display ERROR wheere first and last name would be
    return {"firstName": "Error", "lastName": "Error"};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the structure for the page.
      appBar: AppBar(
        // Sets the background color of the AppBar.
        backgroundColor: const Color(0xFF2D7815), // Dark green.
        // Centers the title text in the AppBar.
        centerTitle: true,
        // Adds a slight shadow to the AppBar for depth.
        elevation: 2,
        // Title of the AppBar.
        title: const Text(
          'Az Canyon College', // Displays the page title.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the title.
            fontSize: 22, // Font size of the title.
            color: Colors.white, // White text color.
          ),
        ),
      ),
      // SafeArea ensures content avoids notches and system UI overlays.
      body: SafeArea(
        child: Column(
          children: [
            /// **Using FutureBuilder to Fetch User Data Asynchronously**
            FutureBuilder<Map<String, String>>(
              future: fetchUserData(), // Calls the async function
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 30.0),
                    child: Text(
                      "Loading...",
                      style: TextStyle(
                        fontFamily: 'Inter Tight',
                        fontSize: 20,
                      ),
                    ),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 30.0),
                    child: Text(
                      "Error fetching data",
                      style: TextStyle(
                        fontFamily: 'Inter Tight',
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  // Successfully fetched user data
                  String firstName = snapshot.data?["firstName"] ?? "Unknown";
                  String lastName = snapshot.data?["lastName"] ?? "Unknown";

                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 30.0),
                    child: Text(
                      "$firstName $lastName",
                      style: const TextStyle(
                        fontFamily: 'Inter Tight',
                        fontSize: 20,
                      ),
                    ),
                  );
                }
              },
            ),
            // Spacer pushes the button towards the bottom of the screen.
            const Spacer(),

            // Centered "Sign Out" button.
            Center(
              child: ElevatedButton(
                // Navigates back to the login page when pressed.
                onPressed: () async {
                  await AuthService().signOut(); // Call signOut method
                  // Navigate to login screen and remove previous routes
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage()), // Replace with your login screen
                    (route) => false, // Removes all previous screens
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D7815),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), // Space below the button.
          ],
        ),
      ),
    );
  }
}
