import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalAvailabilityScreen extends StatefulWidget {
  const HospitalAvailabilityScreen({super.key});

  @override
  _HospitalAvailabilityScreenState createState() => _HospitalAvailabilityScreenState();
}

class _HospitalAvailabilityScreenState extends State<HospitalAvailabilityScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  // Dummy coordinates for the hospital (replace with actual coordinates) 
  final double hospitalLatitude = 13.043261846379503;
  final double hospitalLongitude = 80.24556472927739;

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('hospital'),
        position: LatLng(hospitalLatitude, hospitalLongitude),
        infoWindow: const InfoWindow(title: 'Be Well Hospital'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Availability'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Header
            _buildHospitalHeader(),
            const SizedBox(height: 16),
            // Current Availability Section
            _buildCurrentAvailability(),
            const SizedBox(height: 16),
            // Emergency Services Section
            _buildEmergencyServices(),
            const SizedBox(height: 16),
            // Specialized Departments Section
            _buildSpecializedDepartments(),
            const SizedBox(height: 16),
            // Location Map & Buttons (Directions, Contact)
            _buildLocationAndContact(context),
          ],
        ),
      ),
    );
  }

  // Build Hospital Header with Name, Logo, and Description
  Widget _buildHospitalHeader() {
    return const Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/bewell_logo.jpg'), // Replace with Be Well logo
          ),
          SizedBox(height: 16),
          Text(
            'Be Well Hospital',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '@bewellhospital',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Build Current Availability Section
  Widget _buildCurrentAvailability() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Availability',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Be Well Group of hospitals is establishing a new order of healthcare delivery to ensure accessible, affordable, and quality care available to all. Be Well has been setting up best hospitals in South India with world-class infrastructure in locations that currently have limited access to all-round healthcare.\n\n'
          'We have won the trust of our patients with our transparent pricing policy, ethical practices, right treatment recommendations, and innovative patient education initiatives, which has made "Be Well" a brand of trust and care.',
        ),
      ],
    );
  }

  // Build Emergency Services Section
  Widget _buildEmergencyServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Emergency Services',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildServiceRow(Icons.bed, 'ER Beds', '12 available'),
        _buildServiceRow(Icons.local_hospital, 'Ambulances', '5 available'),
        _buildServiceRow(Icons.local_hospital, 'Trauma Rooms', '3 available'),
      ],
    );
  }

  Widget _buildServiceRow(IconData icon, String serviceName, String availability) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 8),
          Text(serviceName, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(availability, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // Build Specialized Departments Section
  Widget _buildSpecializedDepartments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specialized Departments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10.0,
          children: [
            _buildDepartmentChip('Cardiology'),
            _buildDepartmentChip('Neurology'),
            _buildDepartmentChip('Pediatrics'),
            _buildDepartmentChip('Dermatology'),
          ],
        ),
      ],
    );
  }

  Widget _buildDepartmentChip(String departmentName) {
    return Chip(
      label: Text(departmentName),
    );
  }

  // Build Location and Contact Buttons with integrated Map
  Widget _buildLocationAndContact(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(hospitalLatitude, hospitalLongitude),
              zoom: 15.0,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Directions functionality
              },
              icon: const Icon(Icons.directions),
              label: const Text('Directions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Contact functionality
              },
              icon: const Icon(Icons.phone),
              label: const Text('Contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: HospitalAvailabilityScreen(),
  ));
}
