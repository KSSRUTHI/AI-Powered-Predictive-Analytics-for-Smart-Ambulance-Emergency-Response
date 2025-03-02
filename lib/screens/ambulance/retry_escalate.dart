import 'package:flutter/material.dart';

class RetryOrEscalateScreen extends StatefulWidget {
  const RetryOrEscalateScreen({super.key});

  @override
  _RetryOrEscalateScreenState createState() => _RetryOrEscalateScreenState();
}

class _RetryOrEscalateScreenState extends State<RetryOrEscalateScreen> {
  bool _hospitalASelected = false;
  bool _hospitalBSelected = false;
  bool _hospitalCSelected = false;
  bool _hospitalDSelected = false;

  // Function to handle retry submission logic
  void _retrySubmission() {
    List<String> selectedHospitals = [];

    if (_hospitalASelected) selectedHospitals.add('Hospital A');
    if (_hospitalBSelected) selectedHospitals.add('Hospital B');
    if (_hospitalCSelected) selectedHospitals.add('Hospital C');
    if (_hospitalDSelected) selectedHospitals.add('Hospital D');

    if (selectedHospitals.isEmpty) {
      _showSnackBar("Please select at least one hospital to retry.");
    } else {
      _showSnackBar("Retrying submission to: ${selectedHospitals.join(', ')}");
      // Add your logic to retry the submission to selected hospitals here.
    }
  }

  // Function to handle escalate logic
  void _escalateCase() {
    List<String> selectedHospitals = [];

    if (_hospitalASelected) selectedHospitals.add('Hospital A');
    if (_hospitalBSelected) selectedHospitals.add('Hospital B');
    if (_hospitalCSelected) selectedHospitals.add('Hospital C');
    if (_hospitalDSelected) selectedHospitals.add('Hospital D');

    if (selectedHospitals.isEmpty) {
      _showSnackBar("Please select at least one hospital to escalate the case.");
    } else {
      _showSnackBar("Escalating case for: ${selectedHospitals.join(', ')}");
      // Add your logic to escalate the case to a higher authority here.
    }
  }

  // Helper function to show snackbar messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retry or Escalate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rejected Hospitals', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),

            // Checkbox list for hospital rejections
            CheckboxListTile(
              title: const Text('Hospital A - Equipment Unavailable'),
              value: _hospitalASelected,
              onChanged: (value) {
                setState(() {
                  _hospitalASelected = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Hospital B - No Specialist Available'),
              value: _hospitalBSelected,
              onChanged: (value) {
                setState(() {
                  _hospitalBSelected = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Hospital C - Over Capacity'),
              value: _hospitalCSelected,
              onChanged: (value) {
                setState(() {
                  _hospitalCSelected = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Hospital D - Administrative Delay'),
              value: _hospitalDSelected,
              onChanged: (value) {
                setState(() {
                  _hospitalDSelected = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Retry and Escalate buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _retrySubmission,  // Retry logic
                  child: const Text('Retry Submission'),
                ),
                ElevatedButton(
                  onPressed: _escalateCase,  // Escalate logic
                  child: const Text('Escalate Case'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
