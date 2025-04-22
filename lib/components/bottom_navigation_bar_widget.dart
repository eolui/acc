import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//------------------------------------------------------
//      BOTTOM NAV BAR WIDGET
//------------------------------------------------------

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isAdmin;

  /// Constructor
  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current user logged in
    final User? user = FirebaseAuth.instance.currentUser;
    final String? email = user?.email; // Get the email
    // Check if the user's email is "...admin@gmail.com"
    // List of all ADMIN accounts
    final List<String> adminEmails = [
      'tempeadmin@gmail.com',
      'scottsdaleadmin@gmail.com',
      'phoenixadmin@gmail.com',
      'peoriaadmin@gmail.com',
      'mesaadmin@gmail.com',
      'glendaleadmin@gmail.com',
      'gilbertadmin@gmail.com',
      'chandleradmin@gmail.com',
    ];

    final bool isAdmin = adminEmails.contains(email);

    // A list of routes corresponding to each navigation item.
    final List<String> routes = [
      '/home', // Route for the "Home" page
      isAdmin
          ? '/scan'
          : '/qrCode', // Admin goes to /scan, anyone else to /qrCode
      '/gymList', // Route for the "GYMS" page
      '/more', // Route for the "MORE" page
    ];

    return Container(
      // Navigation bar's background color.
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Home icon.
            label: 'Home', // Label for the "Home" item.
          ),
          BottomNavigationBarItem(
            icon: Icon(isAdmin
                ? Icons.scanner
                : Icons.qr_code), // Changes icon dynamically
            label: isAdmin ? 'SCAN' : 'QR CODE', // Changes label dynamically
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
