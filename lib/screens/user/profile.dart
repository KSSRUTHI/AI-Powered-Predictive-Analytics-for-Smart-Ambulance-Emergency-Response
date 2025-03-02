import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // Sample values for the user's profile
  String fullName = 'John Doe';
  String dob = '01/01/1990';
  String gender = 'Male';
  String contactNumber = '1234567890';
  String email = 'john.doe@example.com';
  String emergencyName = 'Jane Doe';
  String relationship = 'Spouse';
  String emergencyContact = '0987654321';
  String medicalConditions = 'None';
  String allergies = 'None';
  String medications = 'None';

  // Controllers to handle editing of profile fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _medicalConditionsController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();

  // Function to handle editing and saving the profile
  void _editProfile() {
    _fullNameController.text = fullName;
    _dobController.text = dob;
    _genderController.text = gender;
    _contactNumberController.text = contactNumber;
    _emailController.text = email;
    _emergencyNameController.text = emergencyName;
    _relationshipController.text = relationship;
    _emergencyContactController.text = emergencyContact;
    _medicalConditionsController.text = medicalConditions;
    _allergiesController.text = allergies;
    _medicationsController.text = medications;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(_fullNameController, 'Full Name'),
                _buildTextField(_dobController, 'Date of Birth'),
                _buildTextField(_genderController, 'Gender'),
                _buildTextField(_contactNumberController, 'Contact Number'),
                _buildTextField(_emailController, 'Email Address'),
                const SizedBox(height: 20),
                _buildTextField(_emergencyNameController, 'Emergency Contact Name'),
                _buildTextField(_relationshipController, 'Relationship'),
                _buildTextField(_emergencyContactController, 'Emergency Contact Number'),
                const SizedBox(height: 20),
                _buildTextField(_medicalConditionsController, 'Medical Conditions'),
                _buildTextField(_allergiesController, 'Allergies'),
                _buildTextField(_medicationsController, 'Medications'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save edited values
                setState(() {
                  fullName = _fullNameController.text;
                  dob = _dobController.text;
                  gender = _genderController.text;
                  contactNumber = _contactNumberController.text;
                  email = _emailController.text;
                  emergencyName = _emergencyNameController.text;
                  relationship = _relationshipController.text;
                  emergencyContact = _emergencyContactController.text;
                  medicalConditions = _medicalConditionsController.text;
                  allergies = _allergiesController.text;
                  medications = _medicationsController.text;
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Personal Information'),
            _buildProfileDetail('Full Name', fullName),
            _buildProfileDetail('Date of Birth', dob),
            _buildProfileDetail('Gender', gender),
            _buildProfileDetail('Contact Number', contactNumber),
            _buildProfileDetail('Email Address', email),
            const SizedBox(height: 20),

            _buildSectionTitle('Emergency Contact'),
            _buildProfileDetail('Emergency Contact Name', emergencyName),
            _buildProfileDetail('Relationship', relationship),
            _buildProfileDetail('Emergency Contact Number', emergencyContact),
            const SizedBox(height: 20),

            _buildSectionTitle('Medical Information'),
            _buildProfileDetail('Medical Conditions', medicalConditions.isEmpty ? 'None' : medicalConditions),
            _buildProfileDetail('Allergies', allergies.isEmpty ? 'None' : allergies),
            _buildProfileDetail('Medications', medications.isEmpty ? 'None' : medications),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _editProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
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

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
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
