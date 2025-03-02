import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AmbulanceProfilePage extends StatefulWidget {
  const AmbulanceProfilePage({super.key});

  @override
  _AmbulanceProfilePageState createState() => _AmbulanceProfilePageState();
}

class _AmbulanceProfilePageState extends State<AmbulanceProfilePage> {
  File? _profileImage;
  bool isEditing = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Profile details (this can be updated dynamically or from a data source)
  String name = 'John Doe';
  String vehicleNumber = 'TN-07-AB-1234';
  String ambulanceType = 'Basic Life Support (BSS)';
  String serviceArea = 'Chennai';
  String contactNumber = '9876543210';
  String licenseNumber = 'XYZ123456';

  // Editing controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vehicleNumberController = TextEditingController();
  final TextEditingController _ambulanceTypeController = TextEditingController();
  final TextEditingController _serviceAreaController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = name;
    _vehicleNumberController.text = vehicleNumber;
    _ambulanceTypeController.text = ambulanceType;
    _serviceAreaController.text = serviceArea;
    _contactNumberController.text = contactNumber;
    _licenseNumberController.text = licenseNumber;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _vehicleNumberController.dispose();
    _ambulanceTypeController.dispose();
    _serviceAreaController.dispose();
    _contactNumberController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            _profileImage == null
                ? const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/default_avatar.png'),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_profileImage!),
                  ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _pickImage,
              child: const Text('Edit Profile Picture'),
            ),

            const SizedBox(height: 20),

            // Profile Information Section
            _buildProfileItem(
              label: 'Name',
              controller: _nameController,
              isEditing: isEditing,
            ),
            _buildProfileItem(
              label: 'Vehicle Number',
              controller: _vehicleNumberController,
              isEditing: isEditing,
            ),
            _buildProfileItem(
              label: 'Ambulance Type',
              controller: _ambulanceTypeController,
              isEditing: isEditing,
            ),
            _buildProfileItem(
              label: 'Service Area',
              controller: _serviceAreaController,
              isEditing: isEditing,
            ),
            _buildProfileItem(
              label: 'Contact Number',
              controller: _contactNumberController,
              isEditing: isEditing,
            ),
            _buildProfileItem(
              label: 'License Number',
              controller: _licenseNumberController,
              isEditing: isEditing,
            ),

            const SizedBox(height: 30),

            // Edit Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(isEditing ? 'Save' : 'Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            enabled: isEditing,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
        ],
      ),
    );
  }
}
