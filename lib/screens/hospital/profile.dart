import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TextEditingControllers to handle user input
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _hospitalAddressController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _adminPositionController = TextEditingController();
  final TextEditingController _adminContactController = TextEditingController();
  final TextEditingController _departmentsController = TextEditingController();

  // Boolean to check if the form is in edit mode
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initial data; could also be fetched from a backend or database
    _hospitalNameController.text = "Be Well Hospital";
    _hospitalAddressController.text = "1234 Wellness Road";
    _contactNumberController.text = "123-456-7890";
    _emailAddressController.text = "contact@bewell.com";
    _adminNameController.text = "John Doe";
    _adminPositionController.text = "Chief Medical Officer";
    _adminContactController.text = "987-654-3210";
    _departmentsController.text = "Cardiology, Neurology, Orthopedics, Pediatrics";
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _hospitalNameController.dispose();
    _hospitalAddressController.dispose();
    _contactNumberController.dispose();
    _emailAddressController.dispose();
    _adminNameController.dispose();
    _adminPositionController.dispose();
    _adminContactController.dispose();
    _departmentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Profile'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Hospital Profile',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hospital Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildProfileItem('Hospital Name', _hospitalNameController),
              _buildProfileItem('Hospital Address', _hospitalAddressController),
              _buildProfileItem('Contact Number', _contactNumberController),
              _buildProfileItem('Email Address', _emailAddressController),
              const SizedBox(height: 20),
              const Text(
                'Administrator Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildProfileItem('Admin Name', _adminNameController),
              _buildProfileItem('Admin Position', _adminPositionController),
              _buildProfileItem('Admin Contact', _adminContactController),
              const SizedBox(height: 20),
              const Text(
                'Departments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildProfileItem('Available Departments', _departmentsController),
              const SizedBox(height: 30),
              if (_isEditing)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                      // Here you can add logic to save the edited data to the backend or database
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Save Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build profile information display
  Widget _buildProfileItem(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        _isEditing
            ? TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              )
            : Text(
                controller.text,
                style: const TextStyle(fontSize: 16),
              ),
        const Divider(height: 20, color: Colors.grey),
      ],
    );
  }
}
