import 'package:flutter/material.dart';
import 'package:flutter_app/screens/ambulance/dashboard.dart';
import 'package:flutter_app/screens/ambulance/vital_information.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login / Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardAmbulancePage()),
                    );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Handle registration logic here
              },
              child: const Text('New User? Register here'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Handle emergency login request here
                 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PatientVitalSubmission()),
                    );
              },
              child: const Text('! Start Emergency Request'),
            ),
          ],
        ),
      ),
    );
  }
}