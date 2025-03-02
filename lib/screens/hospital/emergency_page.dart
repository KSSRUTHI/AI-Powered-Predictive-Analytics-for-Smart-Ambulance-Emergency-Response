import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmergencyWardPage extends StatefulWidget {
  const EmergencyWardPage({super.key});

  @override
  State<EmergencyWardPage> createState() => _EmergencyWardPageState();
}

class _EmergencyWardPageState extends State<EmergencyWardPage> {
  final List<XFile> _imageFiles = []; // Properly initialize image list

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFiles.add(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Ward'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Ensure page scrolls if content overflows
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Number of Available Rooms',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 10), // Added space between text fields
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Pregnancy Rooms Available',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Number of Emergency Ward Beds Available',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Number of Available Incubators',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Number of Available Doctors',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'UPLOAD ALL THE IMAGES WHICH ARE MENTIONED IN THE ABOVE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Upload Image'),
              ),
              if (_imageFiles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true, // Ensure ListView does not take infinite height
                    itemCount: _imageFiles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Image.file(
                          File(_imageFiles[index].path),
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "SUBMIT" action
                    },
                    child: const Text('SUBMIT'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "NEXT" action
                    },
                    child: const Text('NEXT'),
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
