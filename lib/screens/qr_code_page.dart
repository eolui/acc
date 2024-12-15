import 'package:flutter/material.dart';

/// A stateless widget representing the QR Code page.
class QRCodePage extends StatelessWidget {
  const QRCodePage({Key? key}) : super(key: key);

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
        child: Column(
          // Centers the content vertically in the available space.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered QR Code display area.
            Center(
              child: Container(
                // Sets the width of the QR Code container.
                width: 291,
                // Sets the height of the QR Code container.
                height: 375,
                // Decoration for the container, including background color and rounded corners.
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surface, // Background color.
                  borderRadius:
                      BorderRadius.circular(2), // Slightly rounded corners.
                ),
                // Center the text within the container.
                child: const Center(
                  // Placeholder text for the QR Code.
                  child: Text(
                    'QR Code', // Replace with a QR Code widget in the future.
                    style: TextStyle(
                      fontSize: 18, // Font size for the text.
                      fontWeight: FontWeight.bold, // Bold text style.
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(), // Pushes any additional content toward the bottom.
          ],
        ),
      ),
    );
  }
}
