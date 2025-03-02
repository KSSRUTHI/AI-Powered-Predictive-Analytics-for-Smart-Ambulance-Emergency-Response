import 'package:flutter/material.dart';

class PatientVitalInformationPage extends StatefulWidget {
  const PatientVitalInformationPage({super.key});

  @override
  _PatientVitalInformationPageState createState() => _PatientVitalInformationPageState();
}

class _PatientVitalInformationPageState extends State<PatientVitalInformationPage> {
  // Controllers to manage text field values
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _heartbeatController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _assignedDoctorController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  bool _isEditing = false; // Flag to determine if we're in edit mode

  @override
  void initState() {
    super.initState();
    // Populate the fields with sample data
    _bloodPressureController.text = "120/80 mmHg"; // Sample Blood Pressure
    _heartbeatController.text = "72 bpm";          // Sample Heartbeat
    _conditionController.text = "Stable";          // Sample Condition
    _bloodTypeController.text = "O+";              // Sample Blood Type
    _assignedDoctorController.text = "Dr. John Doe";  // Sample Doctor
    _departmentController.text = "Cardiology";     // Sample Department
    _requirementsController.text = "N/A";          // Sample Specialized Requirements
  }

  // A function to toggle between edit and view modes
  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  // Function to remove patient information
  void _removePatientInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Removal'),
          content: const Text('Are you sure you want to remove this information?'),
          actions: [
            TextButton(
              onPressed: () {
                // Clear the text fields
                _bloodPressureController.clear();
                _heartbeatController.clear();
                _conditionController.clear();
                _bloodTypeController.clear();
                _assignedDoctorController.clear();
                _departmentController.clear();
                _requirementsController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when the page is closed
    _bloodPressureController.dispose();
    _heartbeatController.dispose();
    _conditionController.dispose();
    _bloodTypeController.dispose();
    _assignedDoctorController.dispose();
    _departmentController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Vital Information'),
      ),
      resizeToAvoidBottomInset: true,  // Adjust screen when keyboard is opened
      body: SingleChildScrollView(  // Make the entire view scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Patient Vital Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bloodPressureController,
              decoration: const InputDecoration(
                labelText: 'Enter Blood Pressure',
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing, // Disable field if not in edit mode
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _heartbeatController,
              decoration: const InputDecoration(
                labelText: 'Enter Heartbeat Range',
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _conditionController,
              decoration: const InputDecoration(
                labelText: 'Enter Current Condition',
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Request Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bloodTypeController,
              decoration: const InputDecoration(
                labelText: 'Blood Type Needed',
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _assignedDoctorController,
              decoration: const InputDecoration(
                labelText: 'Assigned Doctor',
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _departmentController,
              decoration: const InputDecoration(
                labelText: 'Assigned Department',
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _requirementsController,
              decoration: const InputDecoration(
                labelText: 'Specialized Requirements',
                border: OutlineInputBorder(),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _toggleEditMode, // Toggle between edit and view mode
                  child: Text(_isEditing ? 'SAVE' : 'EDIT'),
                ),
                ElevatedButton(
                  onPressed: _removePatientInfo, // Show confirmation dialog for removing
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('REMOVE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
