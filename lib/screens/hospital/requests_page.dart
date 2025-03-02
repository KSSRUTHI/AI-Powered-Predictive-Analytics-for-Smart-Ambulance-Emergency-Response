import 'package:flutter/material.dart';

class IncomingRequestsPage extends StatelessWidget {
  const IncomingRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Patient Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Patient Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Medical Needs',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Timestamp',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Request Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Comprehensive Patient Information',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Specific Requirements',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              // Wrap the buttons to prevent overflow
              Wrap(
                spacing: 16.0, // Spacing between buttons
                runSpacing: 8.0, // Spacing between rows of buttons, if wrapped
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Accept Request" action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Accept Request'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Reject Request" action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Reject Request'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "Assign Department" action
                    },
                    child: const Text('Assign Department'),
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
