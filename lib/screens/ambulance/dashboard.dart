import 'package:flutter/material.dart';
import 'package:flutter_app/screens/ambulance/ambulance_availability.dart';
import 'package:flutter_app/screens/ambulance/confirmation_details.dart';
import 'package:flutter_app/screens/ambulance/notifications_screen.dart';
import 'package:flutter_app/screens/ambulance/real_time_tracking.dart';
import 'package:flutter_app/screens/ambulance/responses_page.dart';
import 'package:flutter_app/screens/ambulance/retry_escalate.dart';
import 'package:flutter_app/screens/ambulance/get_vitals.dart';
import 'package:flutter_app/screens/ambulance/submit_vitals.dart';
import 'package:flutter_app/screens/ambulance/profile.dart'; // Import profile.dart
import 'login_page.dart';

class DashboardAmbulancePage extends StatefulWidget {
  const DashboardAmbulancePage({super.key});

  @override
  _DashboardAmbulancePageState createState() => _DashboardAmbulancePageState();
}

class _DashboardAmbulancePageState extends State<DashboardAmbulancePage> {
  final int _selectedIndex = 0; // Keep track of the selected tab
  final List<Map<String, dynamic>> _allLinks = [
    {
      'title': 'Nearby Hospitals',
      'image': 'assets/images/search_hos_image.png',
      'page': const NearbyHospitalsScreen(),
    },
    {
      'title': 'Send Patient Vitals',
      'image': 'assets/images/patient_vitals_image.jpeg',
      'page': const SubmitVitals(),
    },
    {
      'title': 'Hospital Response Page',
      'image': 'assets/images/response_image.webp',
      'page': const HospitalResponseScreen(),
    },
    {
      'title': 'Confirmation Page',
      'image': 'assets/images/confirmation_image.webp',
      'page': const PatientHandover(),
    },
    {
      'title': 'Retry or Escalate',
      'image': 'assets/images/retry_image.jpeg',
      'page': const RetryOrEscalateScreen(),
    },
    {
      'title': 'Ambulance Availability',
      'image': 'assets/images/ambulance_availability.png',
      'page': const AmbulanceAvailabilityScreen(),
    },
  ];

  List<Map<String, dynamic>> _filteredLinks = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredLinks = _allLinks; // Initialize filtered links
  }

  // Method to handle taps on BottomNavigationBar items
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        // Navigate to Home (Current Page)
        break;
      case 1:
        // Navigate to Get Vitals Page (get_vitals.dart)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GetVitals()),
        );
        break;
      case 2:
        // Navigate to Profile Page (profile.dart)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AmbulanceProfilePage()),
        );
        break;
      case 3:
        // If Logout is tapped, navigate to the LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginRegisterScreen()),
        );
        break;
    }
  }

  // Method to filter links based on the search query
  void _filterLinks(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredLinks = _allLinks;
      } else {
        _filteredLinks = _allLinks
            .where((link) =>
                link['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Hero! Let us save the patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: _filterLinks, // Update the filtered links on text change
              decoration: InputDecoration(
                hintText: 'Search here',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Navigation Links',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _filteredLinks.isEmpty && _searchQuery.isNotEmpty
                  ? Center(
                      child: Text(
                        'No results found for "$_searchQuery"',
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.0, // Make the tiles square
                      children: _filteredLinks.map((link) {
                        return dashboardTile(link['title'], link['image'], () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => link['page']),
                          );
                        });
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Highlight the selected tab
        selectedItemColor: Colors.teal, // Color of the selected item
        unselectedItemColor: Colors.grey, // Color of unselected items
        onTap: _onItemTapped, // Handle taps on the BottomNavigationBar
        type: BottomNavigationBarType.fixed, // Ensure all items are shown equally
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Patient Vitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  // Reusable dashboard tile widget with the image fully covering the tile and text on top
  Widget dashboardTile(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover, // Image covers the entire container
              ),
            ),
          ),
          // Semi-transparent black overlay to make the text stand out
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.4), // Black overlay with transparency
            ),
          ),
          // Title text on top of the image
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add some padding
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text to stand out on the black overlay
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
