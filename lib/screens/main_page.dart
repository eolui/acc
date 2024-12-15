import 'package:flutter/material.dart';
import 'home_page.dart';
import 'qr_code_page.dart';
import 'gym_list_page.dart';
import 'more_page.dart';

/// A stateful widget that represents the main page with a bottom navigation bar.
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Tracks the currently selected index in the bottom navigation bar.
  int _currentIndex = 0;

  // Controller for managing the pages in the PageView.
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController and set the initial page to the current index.
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // Dispose of the PageController to free up resources.
    _pageController.dispose();
    super.dispose();
  }

  // Handles taps on the bottom navigation bar and switches the PageView page.
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index.
    });
    // Animate the PageView to the selected page.
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300), // Animation duration.
      curve: Curves.easeInOut, // Animation curve.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PageView displays the content for each page.
      body: PageView(
        controller: _pageController, // Controls the current page.
        // Disables swiping to switch between pages.
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(), // First page: Home.
          QRCodePage(), // Second page: QR Code.
          GymListPage(), // Third page: Gym List.
          MorePage(), // Fourth page: More options.
        ],
      ),
      // BottomNavigationBar allows the user to switch between pages.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlights the current tab.
        onTap: _onTabTapped, // Calls the handler when a tab is tapped.
        backgroundColor: const Color(0xFF2D7815), // Dark green background.
        selectedItemColor: Colors.white, // Color for selected items.
        unselectedItemColor: Colors.white70, // Color for unselected items.
        type: BottomNavigationBarType.fixed, // Ensures all items are displayed.
        items: const [
          // Home tab.
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icon for the Home tab.
            label: 'Home', // Label for the Home tab.
          ),
          // QR Code tab.
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code), // Icon for the QR Code tab.
            label: 'QR CODE', // Label for the QR Code tab.
          ),
          // Gyms tab.
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics), // Icon for the Gyms tab.
            label: 'GYMS', // Label for the Gyms tab.
          ),
          // More tab.
          BottomNavigationBarItem(
            icon: Icon(Icons.menu), // Icon for the More tab.
            label: 'MORE', // Label for the More tab.
          ),
        ],
      ),
    );
  }
}
