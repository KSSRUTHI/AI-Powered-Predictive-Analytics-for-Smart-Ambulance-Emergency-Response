import 'package:flutter/material.dart';

class HospitalDetailsScreen extends StatelessWidget {
  final String hospitalName;

  const HospitalDetailsScreen({required this.hospitalName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospitalName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sample content; replace with actual hospital details
            Text(
              hospitalName,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Address: 123 Main Street, City, Country',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Phone: (123) 456-7890',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Hours: Mon - Fri, 9 AM - 5 PM',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle contact hospital action
              },
              child: const Text('Contact Hospital'),
            ),
          ],
        ),
      ),
    );
  }
}
