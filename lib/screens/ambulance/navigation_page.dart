import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalNavigationScreen extends StatefulWidget {
  const HospitalNavigationScreen({super.key});

  @override
  _HospitalNavigationScreenState createState() => _HospitalNavigationScreenState();
}

class _HospitalNavigationScreenState extends State<HospitalNavigationScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {}; // Initialize with a set for markers

  // Dummy coordinates for the hospital (replace with actual coordinates)
  final double hospitalLatitude = 37.7749;
  final double hospitalLongitude = -122.4194;

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('hospital'),
        position: LatLng(hospitalLatitude, hospitalLongitude),
        infoWindow: const InfoWindow(title: 'Hospital'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigate to Hospital'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(hospitalLatitude, hospitalLongitude),
          zoom: 15.0,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
      bottomSheet: const BottomSheetContent(),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ETA: 15 mins'),
          ElevatedButton(
            onPressed: () {
              // Handle contact hospital logic here
            },
            child: const Text('Contact Hospital'),
          ),
          const SizedBox(height: 16.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Estimated Time of Arrival:'),
              Text('15 mins'),
            ],
          ),
        ],
      ),
    );
  }
}
