import 'package:flutter/material.dart';
import 'package:flutter_app/screens/user/login.dart'; // Importing the login page
import 'package:flutter_app/screens/user/dashboard.dart'; // Import the dashboard page

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _medicalConditionsController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();

  bool _agreeToTerms = false;

  void _register() {
    if (_agreeToTerms) {
      // Implement registration logic here (e.g., API call)

      // Navigate to Dashboard page upon successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      // Handle case where terms are not agreed to
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms and conditions')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Personal Information'),
            _buildTextField(_fullNameController, 'Enter Full Name'),
            _buildTextField(_dobController, 'Enter Date of Birth'),
            _buildTextField(_genderController, 'Enter Gender'),
            _buildTextField(_contactNumberController, 'Enter Contact Number'),
            _buildTextField(_emailController, 'Enter Email Address'),
            const SizedBox(height: 20),

            _buildSectionTitle('Authentication Details'),
            _buildTextField(_usernameController, 'Enter Username'),
            _buildTextField(_passwordController, 'Enter Password', obscureText: true),
            _buildTextField(_confirmPasswordController, 'Confirm Password', obscureText: true),
            const SizedBox(height: 20),

            _buildSectionTitle('Emergency Contact'),
            _buildTextField(_emergencyNameController, 'Enter Full Name'),
            _buildTextField(_relationshipController, 'Relationship Type'),
            _buildTextField(_emergencyContactController, 'Enter Contact Number'),
            const SizedBox(height: 20),

            _buildSectionTitle('Medical Information'),
            _buildTextField(_medicalConditionsController, 'Existing Medical Conditions'),
            _buildTextField(_allergiesController, 'Allergies Specification'),
            _buildTextField(_medicationsController, 'Current Medications'),
            const SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text('I agree to the terms and conditions'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: _agreeToTerms ? _register : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Register', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to the login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginUserPage()), // Navigate to login.dart
                  );
                },
                child: const Text('Existing User? Login Here'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.teal.withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
