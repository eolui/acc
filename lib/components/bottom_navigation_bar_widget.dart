import 'package:flutter/material.dart';

/// A stateless widget representing a bottom navigation bar with navigation functionality.
class BottomNavigationBarWidget extends StatelessWidget {
  // The currently selected index of the navigation bar.
  final int currentIndex;

  // A callback function triggered when a navigation item is tapped, passing the selected index.
  final ValueChanged<int> onTap;

  /// Constructor to initialize the required parameters [currentIndex] and [onTap].
  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A list of routes corresponding to each navigation item.
    final List<String> routes = [
      '/home', // Route for the "Home" page (index 0).
      '/qrCode', // Route for the "QR CODE" page (index 1).
      '/gymList', // Route for the "GYMS" page (index 2).
      '/more', // Route for the "MORE" page (index 3).
    ];

    return Container(
      // A decoration to give the navigation bar a background color.
      decoration: const BoxDecoration(
        color: Color(0xFF2D7815), // Dark green color.
      ),
      child: BottomNavigationBar(
        // The currently selected index.
        currentIndex: currentIndex,
        // Callback function triggered when an item is tapped.
        onTap: (index) {
          // Prevents reloading the same page; only navigates if a different index is tapped.
          if (currentIndex != index) {
            // Navigates to the selected route, replacing the current screen.
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
        // Background color of the navigation bar (set to transparent to allow the container's color to show).
        backgroundColor: Colors.transparent,
        // Color of the selected item's icon and label.
        selectedItemColor: Colors.white,
        // Color of unselected items' icons and labels.
        unselectedItemColor: Colors.white70,
        // Ensures all items are displayed with fixed widths.
        type: BottomNavigationBarType.fixed,
        // List of items in the bottom navigation bar.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Home icon.
            label: 'Home', // Label for the "Home" item.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code), // QR code icon.
            label: 'QR CODE', // Label for the "QR CODE" item.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics), // Gymnastics icon.
            label: 'GYMS', // Label for the "GYMS" item.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu), // Menu icon.
            label: 'MORE', // Label for the "MORE" item.
          ),
        ],
      ),
    );
  }
}
