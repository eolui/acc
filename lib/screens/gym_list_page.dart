import 'package:flutter/material.dart';

/// A stateless widget that represents the Gym List Page in the app.
class GymListPage extends StatelessWidget {
  // Constructor for the GymListPage widget.
  const GymListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A basic page structure with an AppBar at the top.
      appBar: AppBar(
        // Sets the background color of the AppBar.
        backgroundColor: const Color(0xFF2D7815), // Dark green.
        // Centers the title within the AppBar.
        centerTitle: true,
        // Adds a slight shadow under the AppBar for depth.
        elevation: 2,
        // The title of the AppBar.
        title: const Text(
          'Az Canyon College', // Displays the title of the page.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the title.
            fontSize: 22, // Font size for the title text.
            color: Colors.white, // White color for the title text.
          ),
        ),
      ),
      // Body of the page, enclosed within a SafeArea to avoid notches and system UI areas.
      body: SafeArea(
        // The main layout of the page, using a column to stack widgets vertically.
        child: Column(
          // Centers the child widgets vertically within the column.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A touch-sensitive widget that navigates to another page when tapped.
            InkWell(
              // The action to perform when the widget is tapped.
              onTap: () {
                // Navigates to the '/specificGymList' route.
                Navigator.pushNamed(context, '/specificGymList');
              },
              // A container to hold and style the content.
              child: Container(
                // Sets the width of the container.
                width: 291,
                // Sets the height of the container.
                height: 375,
                // Decoration to style the container.
                decoration: BoxDecoration(
                  // Uses the theme's surface color for the background.
                  color: Theme.of(context).colorScheme.surface,
                  // Rounds the corners of the container.
                  borderRadius: BorderRadius.circular(2),
                ),
                // Aligns and centers the child text inside the container.
                child: const Center(
                  // Text displayed inside the container.
                  child: Text(
                    'Gym List Page Content', // Placeholder content.
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
