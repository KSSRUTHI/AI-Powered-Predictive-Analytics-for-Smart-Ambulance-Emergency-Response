import 'package:flutter/material.dart';
import 'package:flutter_app/screens/ambulance/navigation_page.dart';

class HospitalResponseScreen extends StatelessWidget {
  const HospitalResponseScreen({super.key});

  // Function to simulate resending vitals
  void _resendVitals() {
    // Add actual logic to resend vitals here
    print("Resending vitals to hospitals...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Response from Hospitals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hospital Response Card - City Hospital
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.red),
                title: const Text(
                  'City Hospital',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: Approved'),
                      Text('ICU available'),
                    ],
                  ),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to City Hospital
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HospitalNavigationScreen()),
                    );
                  },
                  child: const Text('Proceed'),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Hospital Response Card - St. Mary's Health
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.blue),
                title: const Text(
                  'St. Mary\'s Health',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: Approved'),
                      Text('Pediatrics available'),
                    ],
                  ),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to St. Mary's Health
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HospitalNavigationScreen()),
                    );
                  },
                  child: const Text('Proceed'),
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            // Resend Vitals Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size(double.infinity, 50), // Full-width button
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                // Call function to resend vitals
                _resendVitals();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vitals resent to hospitals!'),
                  ),
                );
              },
              child: const Text(
                'Resend Vitals',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
