import 'package:flutter/material.dart';
import 'package:flutter_app/screens/hospital/blood_bank.dart';
import 'package:flutter_app/screens/hospital/emergency_page.dart';
import 'package:flutter_app/screens/hospital/equipments.dart';
import 'package:flutter_app/screens/hospital/notifications_page.dart';
import 'package:flutter_app/screens/hospital/operation_theatre.dart';
import 'package:flutter_app/screens/hospital/patient_details.dart';
import 'package:flutter_app/screens/hospital/specialized_doctors.dart';
import 'package:flutter_app/screens/hospital/x_ray_center.dart';
import 'login_page.dart'; // Import your LoginPage
import 'requests_page.dart'; // Import the IncomingRequestsPage
import 'profile.dart'; // Import the ProfilePage

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // Keep track of the selected tab
  final List<Map<String, dynamic>> _allLinks = [
    {
      'title': 'Patient Details',
      'image': 'assets/images/image_19.jpeg',
      'page': const PatientVitalInformationPage(),
    },
    {
      'title': 'Emergency Ward',
      'image': 'assets/images/rectangle_8.png',
      'page': const EmergencyWardPage(),
    },
    {
      'title': 'Specialized Doctor',
      'image': 'assets/images/rectangle_72.png',
      'page': const SpecializedDoctorPage(),
    },
    {
      'title': 'Blood Bank Availability',
      'image': 'assets/images/rectangle_83.jpeg',
      'page': const BloodBankAvailabilityPage(),
    },
    {
      'title': 'Equipment',
      'image': 'assets/images/rectangle_7.jpeg',
      'page': const EquipmentsPage(),
    },
    {
      'title': 'X-Ray Center',
      'image': 'assets/images/rectangle_82.jpeg',
      'page': const ScanAvailabilityPage(),
    },
    {
      'title': 'Operation Theatre',
      'image': 'assets/images/rectangle_71.jpeg',
      'page': const OTAvailabilityPage(),
    },
    {
      'title': 'Diagnostics and Surgical Equipments',
      'image': 'assets/images/rectangle_81.jpeg',
      'page': const EquipmentsPage(),
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
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IncomingRequestsPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
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
        title: const Text('Hi John from Be Well Hospital'),
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
            label: 'Requests',
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
