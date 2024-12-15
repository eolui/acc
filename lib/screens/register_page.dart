import 'package:flutter/material.dart';

/// A stateless widget representing the user registration page.
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controllers to manage the input of the TextFields.
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      // Scaffold provides the structure for the page.
      appBar: AppBar(
        // Sets the background color of the AppBar.
        backgroundColor: const Color(0xFF2D7815), // Dark green color.
        // Centers the title in the AppBar.
        centerTitle: true,
        // Adds a slight shadow to the AppBar.
        elevation: 2,
        // Title of the AppBar.
        title: const Text(
          'Az Canyon College', // Page title.
          style: TextStyle(
            fontFamily: 'Inter Tight', // Custom font for the title.
            fontSize: 22, // Font size for the title text.
            color: Colors.white, // White text color.
          ),
        ),
      ),
      // SafeArea ensures content avoids system UI overlays like notches.
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Padding around the content.
          child: SingleChildScrollView(
            // Scrollable column for fields and buttons.
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left.
              children: [
                // First Name Field
                const Text(
                  'First Name', // Label for the First Name field.
                  style: TextStyle(
                    fontFamily: 'Inter Tight', // Custom font.
                    fontSize: 16, // Font size for the label.
                  ),
                ),
                const SizedBox(height: 8), // Space between label and field.
                TextField(
                  controller: firstNameController, // Controller for the field.
                  decoration: InputDecoration(
                    hintText: 'Enter your first name', // Placeholder text.
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
                const SizedBox(height: 16), // Space between fields.

                // Last Name Field
                const Text(
                  'Last Name', // Label for the Last Name field.
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: lastNameController, // Controller for the field.
                  decoration: InputDecoration(
                    hintText: 'Enter your last name', // Placeholder text.
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 16),

                // Username Field
                const Text(
                  'Username', // Label for the Username field.
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: usernameController, // Controller for the field.
                  decoration: InputDecoration(
                    hintText: 'Enter your username', // Placeholder text.
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                const Text(
                  'Password', // Label for the Password field.
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController, // Controller for the field.
                  obscureText: true, // Obscures input for password.
                  decoration: InputDecoration(
                    hintText: 'Enter your password', // Placeholder text.
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                const Text(
                  'Confirm Password', // Label for the Confirm Password field.
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller:
                      confirmPasswordController, // Controller for the field.
                  obscureText:
                      true, // Obscures input for password confirmation.
                  decoration: InputDecoration(
                    hintText: 'Confirm your password', // Placeholder text.
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 24),

                // Register Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/home'); // Navigate to Home.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D7815), // Button color.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24, // Horizontal padding.
                        vertical: 12, // Vertical padding.
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners.
                      ),
                    ),
                    child: const Text(
                      'REGISTER', // Button text.
                      style: TextStyle(
                        fontFamily: 'Inter Tight', // Custom font.
                        color: Colors.white, // Text color.
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Back to Login Link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/login'); // Navigate to Login.
                    },
                    child: const Text(
                      'Back to Login...', // Link text.
                      style: TextStyle(
                        fontFamily: 'Inter Tight', // Custom font.
                        fontSize: 14, // Font size.
                        decoration:
                            TextDecoration.underline, // Underline for the link.
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
