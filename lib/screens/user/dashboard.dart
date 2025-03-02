import 'package:flutter/material.dart';
import 'package:flutter_app/screens/user/booking_confirmation.dart';
import 'package:flutter_app/screens/user/notifications.dart';
import 'package:flutter_app/screens/user/ambulance_booking.dart';
import 'package:flutter_app/screens/user/appointment_booking.dart';
import 'package:flutter_app/screens/user/hospital_facility.dart';
import 'package:flutter_app/screens/user/patient_vitals.dart';
import 'package:flutter_app/screens/user/profile.dart';
import 'package:flutter_app/screens/user/readmissions.dart';
import 'login.dart'; // Import your LoginPage
//import 'requests_page.dart'; // Import the IncomingRequestsPage
//import 'profile.dart'; // Import the ProfilePage

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // Keep track of the selected tab
  final List<Map<String, dynamic>> _allLinks = [
    {
      'title': 'Appointment Booking',
      'image': 'assets/images/appointment_booking.jpeg',
      'page': const AppointmentBookingScreen(),
    },
    {
      'title': 'Hospital Facilities',
      'image': 'assets/images/hospital_facility.jpg',
      'page': const HospitalAvailabilityScreen(),
    },
    {
      'title': 'Ambulance Booking',
      'image': 'assets/images/ab.png',
      'page': const AmbulanceBookingScreen(),
    },
    {
      'title': 'Booking Confirmation and Status',
      'image': 'assets/images/bcon.webp',
      'page': const BookingConfirmationScreen(),
    },
    {
      'title': 'Readmissions',
      'image': 'assets/images/hospital_facility.jpg',
      'page': ReadmissionPredictionScreen(),
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
    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginUserPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PatientVitalsScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfilePage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
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
        title: const Text('Hi Jane Smith'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
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
            // Check if there are any filtered links to display
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
                      childAspectRatio: 1.0, // Adjusted aspect ratio to make tiles square
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
            icon: Icon(Icons.list_alt),
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
