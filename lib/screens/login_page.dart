import 'package:flutter/material.dart';

/// A stateless widget representing the login page.
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controllers to manage the input of the TextFields.
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      // Scaffold provides the basic structure of the page.
      appBar: AppBar(
        // Sets the background color of the AppBar.
        backgroundColor: const Color(0xFF2D7815), // Dark green color.
        // Centers the title text within the AppBar.
        centerTitle: true,
        // Adds a slight shadow to the AppBar.
        elevation: 2,
        // The title displayed in the AppBar.
        title: const Text(
          'Az Canyon College', // Title text.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the title.
            fontSize: 22, // Font size of the title.
            color: Colors.white, // White color for the text.
          ),
        ),
      ),
      // SafeArea ensures the content avoids system UI areas (like notches).
      body: SafeArea(
        // Padding around the content for better spacing.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // Centers the content vertically.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username Field.
              Row(
                children: [
                  // Label for the username field.
                  const Padding(
                    padding:
                        EdgeInsets.only(right: 8.0), // Spacing to the right.
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontFamily: 'Inter Tight', // Custom font for the label.
                        fontSize: 18, // Font size for the label text.
                      ),
                    ),
                  ),
                  // TextField for username input.
                  Expanded(
                    child: TextField(
                      controller:
                          usernameController, // Controller for the field.
                      decoration: InputDecoration(
                        hintText: 'Enter your username', // Placeholder text.
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners.
                        ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surface, // Background color.
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Spacing between fields.

              // Password Field.
              Row(
                children: [
                  // Label for the password field.
                  const Padding(
                    padding:
                        EdgeInsets.only(right: 8.0), // Spacing to the right.
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Inter Tight', // Custom font for the label.
                        fontSize: 18, // Font size for the label text.
                      ),
                    ),
                  ),
                  // TextField for password input.
                  Expanded(
                    child: TextField(
                      controller:
                          passwordController, // Controller for the field.
                      obscureText: true, // Masks the input text.
                      decoration: InputDecoration(
                        hintText: 'Enter your password', // Placeholder text.
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners.
                        ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surface, // Background color.
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24), // Spacing between fields and buttons.

              // Row for Login and Register Buttons.
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // Even spacing between buttons.
                children: [
                  // Login Button.
                  ElevatedButton(
                    onPressed: () {
                      // Navigates to the main page and replaces the current page.
                      Navigator.pushReplacementNamed(context, '/main');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D7815), // Button color.
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12), // Button padding.
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners.
                      ),
                    ),
                    child: const Text(
                      'LOGIN', // Button label.
                      style: TextStyle(
                        fontFamily: 'Inter Tight', // Custom font for the label.
                        color: Colors.white, // White text color.
                      ),
                    ),
                  ),
                  // Register Button.
                  ElevatedButton(
                    onPressed: () {
                      // Navigates to the register page.
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D7815), // Button color.
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16), // Button padding.
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners.
                      ),
                    ),
                    child: const Text(
                      'REGISTER', // Button label.
                      style: TextStyle(
                        fontFamily: 'Inter Tight', // Custom font for the label.
                        color: Colors.white, // White text color.
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
