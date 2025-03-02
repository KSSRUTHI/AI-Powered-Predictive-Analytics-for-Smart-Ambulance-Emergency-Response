import 'package:flutter/material.dart';

class PatientHandover extends StatefulWidget {
  const PatientHandover({super.key});

  @override
  _PatientHandoverState createState() => _PatientHandoverState();
}

class _PatientHandoverState extends State<PatientHandover> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();

  bool _isPatientAdmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Handover'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Information
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: const AssetImage('assets/images/confirm_person.jpeg'), // Update with the correct path
                      backgroundColor: Colors.grey[200], // Background color if image not found
                    ),
                    const SizedBox(width: 16.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: John Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Age: 45', style: TextStyle(fontSize: 16)),
                        Text('Gender: Male', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text('Heart Rate: 75 bpm', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8.0),
                const Text('Blood Pressure: 120/80 mmHg', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8.0),
                const Text('Temperature: 98.6°F', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16.0),

                // Patient Handover
                SwitchListTile(
                  title: const Text('Patient Admitted', style: TextStyle(fontSize: 16)),
                  value: _isPatientAdmitted,
                  onChanged: (value) {
                    setState(() {
                      _isPatientAdmitted = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _notesController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Enter notes about patient's condition (Optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.all(12.0),
                  ),
                  // Optional field so no validation required
                  validator: (value) {
                    // No validation required for optional field
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Confirm Handover Button - Centered
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle the confirmation of handover
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Patient handover confirmed!'),
                          ),
                        );
                        // Clear the form fields if needed
                        _notesController.clear();
                        setState(() {
                          _isPatientAdmitted = false;
                        });
                      }
                    },
                    child: const Text('Confirm Handover'),
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
