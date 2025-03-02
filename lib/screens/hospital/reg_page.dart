import 'package:flutter/material.dart';
import 'package:flutter_app/screens/hospital/dashboard_page.dart';
import 'package:flutter_app/screens/hospital/login_page.dart';
import 'package:flutter_app/selection_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _hospitalAddressController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _adminPositionController = TextEditingController();
  final TextEditingController _adminContactController = TextEditingController();
  final TextEditingController _departmentsController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _agreeToTerms = false;

  void _register() {
    // Implement your registration logic here

    // Navigate to DashboardPage after registration logic
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RoleSelectionPage()), // Modify this to your selection page
        );
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RoleSelectionPage()), // Your selection page here
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hospital Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(_hospitalNameController, 'Enter Hospital Name'),
              const SizedBox(height: 10),
              _buildTextField(_hospitalAddressController, 'Enter Hospital Address'),
              const SizedBox(height: 10),
              _buildTextField(_contactNumberController, 'Enter Contact Number'),
              const SizedBox(height: 10),
              _buildTextField(_emailAddressController, 'Enter Email Address'),
              const SizedBox(height: 30),

              const Text(
                'Administrator Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(_adminNameController, 'Enter Name'),
              const SizedBox(height: 10),
              _buildTextField(_adminPositionController, 'Enter Position'),
              const SizedBox(height: 10),
              _buildTextField(_adminContactController, 'Enter Contact Information'),
              const SizedBox(height: 30),

              const Text(
                'List of Departments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(_departmentsController, 'Enter all the available departments', maxLines: 4),
              const SizedBox(height: 30),

              const Text(
                'Authentication Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(_usernameController, 'Enter Username'),
              const SizedBox(height: 10),
              _buildTextField(_passwordController, 'Enter Password', obscureText: true),
              const SizedBox(height: 30),

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
                    child: Text(
                      'I agree to the Terms and Conditions',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('Existing User? Login Here'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false, int maxLines = 1}) {
    return TextField(
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
    );
  }
}
