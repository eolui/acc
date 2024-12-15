import 'package:flutter/material.dart';

/// A stateless widget that represents the Home Page in the application.
class HomePage extends StatelessWidget {
  // Constructor for the HomePage widget.
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic structure for the page.
      appBar: AppBar(
        // Sets the background color of the AppBar.
        backgroundColor: const Color(0xFF2D7815), // Dark green color.
        // Centers the title text in the AppBar.
        centerTitle: true,
        // Adds a slight shadow to the AppBar for depth.
        elevation: 2,
        // The title of the AppBar displayed at the center.
        title: const Text(
          'Az Canyon College', // The title text.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the title.
            fontSize: 22, // Font size of the title text.
            color: Colors.white, // White color for the title.
          ),
        ),
      ),
      // SafeArea ensures that content avoids system UI areas like notches or status bars.
      body: SafeArea(
        // Column widget to arrange child widgets vertically.
        child: Column(
          // Centers child widgets vertically in the available space.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // InkWell makes the container tappable and visually responsive.
            InkWell(
              // Action to be executed when the container is tapped.
              onTap: () {
                // Navigates to the '/specificGymList' page.
                Navigator.pushNamed(context, '/specificGymList');
              },
              // A container to hold and style the content of the clickable area.
              child: Container(
                // Sets the width of the container.
                width: 291,
                // Sets the height of the container.
                height: 375,
                // Decoration for the container, including color and border radius.
                decoration: BoxDecoration(
                  // Uses the theme's surface color for the background.
                  color: Theme.of(context).colorScheme.surface,
                  // Slightly rounds the corners of the container.
                  borderRadius: BorderRadius.circular(2),
                ),
                // Aligns and centers the content inside the container.
                child: const Center(
                  // Text displayed inside the container.
                  child: Text(
                    'Home Page Content', // Placeholder content text.
                    style: TextStyle(
                      fontSize: 18, // Font size of the text.
                      fontWeight: FontWeight.bold, // Bold text style.
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
