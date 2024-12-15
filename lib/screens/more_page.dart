import 'package:flutter/material.dart';

/// A stateless widget that represents the "More" page in the app.
class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

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
        // Column to stack widgets vertically.
        child: Column(
          children: [
            // Display the user's name at the top left.
            const Align(
              alignment: Alignment.centerLeft, // Align text to the left.
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 30.0), // Spacing.
                child: Text(
                  'First name + Last Name', // Placeholder for user's name.
                  style: TextStyle(
                    fontFamily: 'Inter Tight', // Custom font.
                    fontSize: 20, // Font size.
                  ),
                ),
              ),
            ),
            // Spacer pushes the button towards the bottom of the screen.
            const Spacer(),

            // Centered "Sign Out" button.
            Center(
              child: ElevatedButton(
                // Navigates back to the login page when pressed.
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                // Styling for the button.
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D7815), // Button color.
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12), // Button padding.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners.
                  ),
                ),
                // Label for the button.
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(
                    fontFamily: 'Inter Tight', // Custom font for the label.
                    color: Colors.white, // White text color.
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
