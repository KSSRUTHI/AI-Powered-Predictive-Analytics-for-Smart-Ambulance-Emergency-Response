import 'package:flutter/material.dart';
import 'package:flutter_app/screens/user/dashboard.dart';
import 'package:flutter_app/screens/user/register_page.dart'; // Importing the user registration page

class LoginUserPage extends StatelessWidget {
  const LoginUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or icon
            const Image(
              image: AssetImage('assets/images/ambulance_icon.png'), // Replace with your actual asset path
              height: 100,
            ),
            const SizedBox(height: 20.0),

            // Username or Email input field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter Username/Email Address',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Password input field
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Forgot Password button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add forgot password logic
                },
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 24.0),

            // Login button
            ElevatedButton(
              onPressed: () {
                // Handle user login logic here
                // Navigate to User Dashboard after login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()), // Replace this with your dashboard page
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              ),
              child: const Text('Login', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 16.0),

            // New User Registration button
            TextButton(
              onPressed: () {
                // Navigate to the User Registration Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserRegisterPage()), // Navigates to register_page.dart for User side
                );
              },
              child: const Text(
                'New User? Register',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

