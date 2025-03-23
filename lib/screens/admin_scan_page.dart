import 'package:flutter/material.dart';

/// A stateless widget that represents a specific gym list page.
class AdminScanPage extends StatelessWidget {
  const AdminScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic structure for the page.
      appBar: AppBar(
        // Sets the background color of the AppBar.
        backgroundColor: const Color(0xFF2D7815), // Dark green color.
        // Centers the title text in the AppBar.
        centerTitle: true,
        // Adds a slight shadow under the AppBar for depth.
        elevation: 2,
        // Title displayed in the AppBar.
        title: const Text(
          'Az Canyon College', // Title text for the page.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the title.
            fontSize: 22, // Font size for the title.
            color: Colors.white, // White color for the text.
          ),
        ),
      ),
      // SafeArea ensures content avoids system UI overlays, like notches.
      body: SafeArea(
        // Column widget to arrange content vertically.
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers content vertically.
          children: [
            // Main content container.
            Center(
              child: Container(
                // Sets the width of the container.
                width: 291,
                // Sets the height of the container.
                height: 375,
                // Decoration for styling the container.
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surface, // Background color.
                  borderRadius:
                      BorderRadius.circular(2), // Slightly rounded corners.
                ),
                // Content within the container.
                child: const Center(
                  // Placeholder text for specific gym list content.
                  child: Text(
                    'Scan Your QR Code', // Placeholder content.
                    style: TextStyle(
                      fontSize: 18, // Font size of the text.
                      fontWeight: FontWeight.bold, // Bold text for emphasis.
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
