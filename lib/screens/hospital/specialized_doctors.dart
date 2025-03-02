import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SpecializedDoctorPage extends StatefulWidget {
  const SpecializedDoctorPage({super.key});

  @override
  State<SpecializedDoctorPage> createState() => _SpecializedDoctorPageState();
}

class _SpecializedDoctorPageState extends State<SpecializedDoctorPage> {
  final List<XFile> _imageFiles = []; // Properly initialize as a non-nullable list

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
        title: const Text('Specialized Doctor'),
      ),
      body: SingleChildScrollView( // Ensure scrollability
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter the no. of Specialized Doctor Assistants',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 10), // Space between input fields
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter the no. of Male Doctors Available',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter the no. of Female Doctors Available',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Please upload pictures of their IDs for verification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            if (_imageFiles.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
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
                    setState(() {
                      _imageFiles.clear(); // Clear all uploaded images
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('REMOVE'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle "SUBMIT FORM" action
                  },
                  child: const Text('SUBMIT FORM'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
