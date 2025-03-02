import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AmbulanceBookingScreen extends StatefulWidget {
  const AmbulanceBookingScreen({super.key});

  @override
  _AmbulanceBookingScreenState createState() => _AmbulanceBookingScreenState();
}

class _AmbulanceBookingScreenState extends State<AmbulanceBookingScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _oxygenLevelController = TextEditingController();

  bool urgentService = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Ambulance'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Help action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map View for Searching Hospital Location
            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749, -122.4194), // Example coordinates
                  zoom: 14.0,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search Hospital Location',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Ambulance Type Selection
            const Text(
              'Ambulance Type Selection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildAmbulanceTypeOption('Basic - Standard Services', Icons.local_hospital),
            _buildAmbulanceTypeOption('Advanced Life Support', Icons.medical_services),
            _buildAmbulanceTypeOption('Pediatric - Child care', Icons.child_friendly),
            const SizedBox(height: 16),
            // Patient Vitals Input
            const Text(
              'Patient Vitals Input',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildVitalsInput('Heart Rate (bpm)', _heartRateController),
            _buildVitalsInput('Blood Pressure (mmHg)', _bloodPressureController),
            _buildVitalsInput('Oxygen Level (%)', _oxygenLevelController),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Auto-fill from health records functionality
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text('Auto-fill from Health Records'),
            ),
            const SizedBox(height: 16),
            // ETA and Confirmation
            const Text(
              'ETA and Confirmation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Estimated to arrive in 5 minutes\nBooking Details: Urgent Service',
              style: TextStyle(fontSize: 16),
            ),
            SwitchListTile(
              title: const Text('Urgent Service'),
              value: urgentService,
              onChanged: (value) {
                setState(() {
                  urgentService = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Request and Cancel Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Cancel action
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text('Cancel Booking', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Request ambulance action
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text('Request Ambulance'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Ambulance Type Selection
  Widget _buildAmbulanceTypeOption(String label, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 32),
      title: Text(label),
      trailing: Radio(
        value: label,
        groupValue: null, // Replace with selected ambulance type
        onChanged: (value) {
          // Handle ambulance type change
        },
      ),
    );
  }

  // Vitals Input Fields
  Widget _buildVitalsInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _heartRateController.dispose();
    _bloodPressureController.dispose();
    _oxygenLevelController.dispose();
    super.dispose();
  }
}
