import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hospital {
  final String name;
  final LatLng position;
  final String distance;
  final bool hasICU;
  final bool hasEmergencyWard;
  final bool hasPediatrics;
  final bool hasRadiology;
  final bool hasPharmacy;
  final String imageUrl; // Added field for hospital image

  Hospital({
    required this.name,
    required this.position,
    required this.distance,
    required this.hasICU,
    required this.hasEmergencyWard,
    required this.hasPediatrics,
    required this.hasRadiology,
    required this.hasPharmacy,
    required this.imageUrl, // Initialize image URL
  });
}

class NearbyHospitalsScreen extends StatefulWidget {
  const NearbyHospitalsScreen({super.key});

  @override
  _NearbyHospitalsScreenState createState() => _NearbyHospitalsScreenState();
}

class _NearbyHospitalsScreenState extends State<NearbyHospitalsScreen> {
  GoogleMapController? _mapController;
  final List<Marker> _markers = [];

  // List of hospitals with image URLs
  final List<Hospital> _hospitals = [
    Hospital(
      name: 'City Hospital',
      position: const LatLng(13.047115, 80.176892),
      distance: '2.1km',
      hasICU: true,
      hasEmergencyWard: true,
      hasPediatrics: false,
      hasRadiology: true,
      hasPharmacy: true,
      imageUrl: 'assets/images/city_hospital.jpeg', // Replace with actual image URL
    ),
    Hospital(
      name: 'Apollo Hospital',
      position: const LatLng(13.047761, 80.208138),
      distance: '5.4km',
      hasICU: true,
      hasEmergencyWard: true,
      hasPediatrics: true,
      hasRadiology: true,
      hasPharmacy: true,
      imageUrl: 'assets/images/apollo.jpeg', // Replace with actual image URL
    ),
    Hospital(
      name: 'Global Hospital',
      position: const LatLng(13.035902, 80.195276),
      distance: '4.8km',
      hasICU: false,
      hasEmergencyWard: true,
      hasPediatrics: true,
      hasRadiology: true,
      hasPharmacy: false,
      imageUrl: 'assets/images/global.webp', // Replace with actual image URL
    ),
    Hospital(
      name: 'Fortis Hospital',
      position: const LatLng(13.040890, 80.179094),
      distance: '1.9km',
      hasICU: true,
      hasEmergencyWard: true,
      hasPediatrics: false,
      hasRadiology: false,
      hasPharmacy: true,
      imageUrl: 'assets/images/fortis.jpeg', // Replace with actual image URL
    ),
    Hospital(
      name: 'Vijaya Hospital',
      position: const LatLng(13.057828, 80.203792),
      distance: '3.5km',
      hasICU: true,
      hasEmergencyWard: true,
      hasPediatrics: true,
      hasRadiology: true,
      hasPharmacy: true,
      imageUrl: 'assets/images/vijaya_hospital.jpeg', // Replace with actual image URL
    ),
  ];

  // Filter variables
  bool _icuFilter = false;
  bool _emergencyWardFilter = false;
  bool _pediatricFilter = false;
  bool _radiologyFilter = false;
  bool _pharmacyFilter = false;

  @override
  void initState() {
    super.initState();
    _applyFilters(); // Initialize markers
  }

  void _applyFilters() {
    setState(() {
      _markers.clear();
      final filteredHospitals = _hospitals.where((hospital) {
        return (!_icuFilter || hospital.hasICU) &&
               (!_emergencyWardFilter || hospital.hasEmergencyWard) &&
               (!_pediatricFilter || hospital.hasPediatrics) &&
               (!_radiologyFilter || hospital.hasRadiology) &&
               (!_pharmacyFilter || hospital.hasPharmacy);
      }).toList();

      _markers.addAll(
        filteredHospitals.map((hospital) => Marker(
          markerId: MarkerId(hospital.name),
          position: hospital.position,
          infoWindow: InfoWindow(
            title: hospital.name,
            snippet: 'Distance: ${hospital.distance}',
          ),
        )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Hospitals'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Section
            SizedBox(
              height: 250,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(13.047115, 80.176892),
                  zoom: 15.0,
                ),
                markers: Set<Marker>.of(_markers),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),
            ),
            const SizedBox(height: 16.0),

            // Hospital List Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Available Hospitals',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _hospitals.where((hospital) {
                return (!_icuFilter || hospital.hasICU) &&
                       (!_emergencyWardFilter || hospital.hasEmergencyWard) &&
                       (!_pediatricFilter || hospital.hasPediatrics) &&
                       (!_radiologyFilter || hospital.hasRadiology) &&
                       (!_pharmacyFilter || hospital.hasPharmacy);
              }).length,
              itemBuilder: (context, index) {
                final hospital = _hospitals.where((hospital) {
                  return (!_icuFilter || hospital.hasICU) &&
                         (!_emergencyWardFilter || hospital.hasEmergencyWard) &&
                         (!_pediatricFilter || hospital.hasPediatrics) &&
                         (!_radiologyFilter || hospital.hasRadiology) &&
                         (!_pharmacyFilter || hospital.hasPharmacy);
                }).toList()[index];
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        hospital.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        hospital.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Distance: ${hospital.distance}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Handle hospital selection logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text('Select'),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),

            // Filter Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Filter Options',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text('ICU'),
                    value: _icuFilter,
                    activeColor: Colors.teal,
                    onChanged: (value) {
                      setState(() {
                        _icuFilter = value!;
                        _applyFilters();
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Emergency Ward'),
                    value: _emergencyWardFilter,
                    activeColor: Colors.teal,
                    onChanged: (value) {
                      setState(() {
                        _emergencyWardFilter = value!;
                        _applyFilters();
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Pediatrics'),
                    value: _pediatricFilter,
                    activeColor: Colors.teal,
                    onChanged: (value) {
                      setState(() {
                        _pediatricFilter = value!;
                        _applyFilters();
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Radiology'),
                    value: _radiologyFilter,
                    activeColor: Colors.teal,
                    onChanged: (value) {
                      setState(() {
                        _radiologyFilter = value!;
                        _applyFilters();
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Pharmacy'),
                    value: _pharmacyFilter,
                    activeColor: Colors.teal,
                    onChanged: (value) {
                      setState(() {
                        _pharmacyFilter = value!;
                        _applyFilters();
                      });
                    },
                  ),
                  SizedBox(
              height: 200,
              width: double.infinity, // Ensure it fits the screen width
              child: Image.asset(
                'assets/images/rectangle.png', // Replace with the path to your rough map image
                fit: BoxFit.cover,
              ),
            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
