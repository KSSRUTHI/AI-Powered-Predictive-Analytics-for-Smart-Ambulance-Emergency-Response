import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/ambulance/registration_page.dart';
import 'package:flutter_app/screens/hospital/reg_page.dart';
import 'package:flutter_app/screens/user/register_page.dart';  // Import the user registration page

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please Select'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add back navigation logic here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Instructions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please select an option to proceed: Ambulance, Hospital, or User. Your selection will guide the next steps in connecting services.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              _buildSelectionCard(
                context,
                title: 'Ambulance Selection',
                description:
                    'Ambulance Side: Connects drivers with hospitals for emergencies.',
                buttonText: 'Proceed to Ambulance Side',
                buttonColor: Colors.red,
                onPressed: () {
                  // Handle Ambulance Selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AmbulanceRegistrationApp()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildSelectionCard(
                context,
                title: 'Hospital Selection',
                description:
                    'Hospital Side: Connects hospitals with ambulance services for patient admissions.',
                buttonText: 'Proceed to Hospital Side',
                buttonColor: Colors.blue,
                onPressed: () {
                  // Handle Hospital Selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildSelectionCard(
                context,
                title: 'User Side',
                description:
                    'Proceed as a general user to access features and services.',
                buttonText: 'Proceed to User Side',
                buttonColor: Colors.green,
                onPressed: () {
                  // Handle User Selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserRegisterPage()),  // Navigate to the user registration page
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCard(BuildContext context,
      {required String title,
      required String description,
      required String buttonText,
      required Color buttonColor,
      required VoidCallback onPressed}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Text color set to white
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

void main() {
  runApp(const MaterialApp(
    home: RoleSelectionPage(),
  ));
}
