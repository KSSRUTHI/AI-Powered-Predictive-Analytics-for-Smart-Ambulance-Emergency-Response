import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/ambulance/dashboard.dart';
import 'package:flutter_app/screens/ambulance/login_page.dart';
import 'package:flutter_app/selection_page.dart';
import 'package:image_picker/image_picker.dart';
 // Import your selection page


void main() {
  runApp(const AmbulanceRegistrationApp());
}

class AmbulanceRegistrationApp extends StatelessWidget {
  const AmbulanceRegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.teal.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
      home: const AmbulanceRegistrationForm(),
    );
  }
}

class AmbulanceRegistrationForm extends StatefulWidget {
  const AmbulanceRegistrationForm({super.key});

  @override
  _AmbulanceRegistrationFormState createState() =>
      _AmbulanceRegistrationFormState();
}

class _AmbulanceRegistrationFormState extends State<AmbulanceRegistrationForm> {
  bool agreeToTerms = false;
  File? _certificateImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _certificateImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the selection page when back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RoleSelectionPage()), // Modify this to your selection page
        );
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle manual back navigation to selection page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RoleSelectionPage()), // Your selection page here
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ambulance Information Section
              const Text(
                'Ambulance Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Vehicle Number',
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: 'Enter type of Ambulance',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Basic Life Support (BSS)',
                    child: Text('Basic Life Support (BSS)'),
                  ),
                  DropdownMenuItem(
                    value: 'Advanced Life Support (ASS)',
                    child: Text('Advanced Life Support (ASS)'),
                  ),
                ],
                onChanged: (value) {
                  // Handle ambulance type change
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Service Area Coverage',
                ),
              ),
              const SizedBox(height: 30),

              // Driver/Crew Details Section
              const Text(
                'Driver/Crew Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter License Number',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Contact Number',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 30),

              // Certifications Section
              const Text(
                'Certifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              _certificateImage == null
                  ? const Text('No image selected.')
                  : Image.file(
                      _certificateImage!,
                      height: 150,
                    ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Upload Certification Image'),
              ),
              const SizedBox(height: 30),

              // Agree to Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to the Terms and Conditions',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),

              // Register Button
              Center(
                child: ElevatedButton(
                  onPressed: agreeToTerms
                      ? () {
                          // Submit registration data
                          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardAmbulancePage()),
                    );
                        }
                      : null, // Disable the button if terms are not agreed
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Register', style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),

              // Login Option for Existing Users
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginRegisterScreen()),
                    );
                  },
                  child: const Text('Existing User? Login Here'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
