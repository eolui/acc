import 'package:acc/models/loginuser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:acc/services/auth.dart';

/// A stateless widget representing the user registration page.
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers to manage the input of the TextFields.
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
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

                // Email Field
                const Text(
                  'Email', // Label for the Email field.
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController, // Controller for the field.
                  decoration: InputDecoration(
                    hintText: 'Enter your email', // Placeholder text.
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
                    onPressed: () async {
                      final firstName = firstNameController.text.trim();
                      final lastName = lastNameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      final confirmPassword =
                          confirmPasswordController.text.trim();

                      // Validate fields
                      if (firstName.isEmpty ||
                          lastName.isEmpty ||
                          email.isEmpty ||
                          password.isEmpty ||
                          confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill in all fields.')),
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Passwords do not match.')),
                        );
                        return;
                      }

                      try {
                        // Create a LoginUser object
                        final loginUser =
                            LoginUser(email: email, password: password);

                        // Call registerEmailPassword from AuthService
                        final result = await AuthService()
                            .registerEmailPassword(loginUser);

                        if (result.uid != null) {
                          // Registration successful, save firstName and lastName to Realtime Database
                          DatabaseReference userRef = FirebaseDatabase.instance
                              .ref()
                              .child("users")
                              .child(result.uid);

                          await userRef.set({
                            "firstName": firstName,
                            "lastName": lastName,
                            "email": email,
                            "uid": result.uid
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Registration successful!')),
                          );
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          // Registration failed, show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${result.code}')),
                          );
                        }
                      } catch (e) {
                        // Handle unexpected errors
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An error occurred: $e')),
                        );
                      }
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
