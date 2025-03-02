import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({super.key});

  @override
  _BookingConfirmationScreenState createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  GoogleMapController? _mapController;
  final LatLng _center = const LatLng(51.5, 0);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        backgroundColor: Colors.white,
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Summary Section
            const Text(
              'Booking Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildBookingDetail(Icons.access_time, 'Appointment: 10:00 AM'),
            _buildBookingDetail(Icons.local_hospital, 'Hospital: City Health'),
            _buildBookingDetail(Icons.person, 'Doctor: Dr. Smith'),
            _buildBookingDetail(Icons.local_taxi, 'Ambulance: On Call'),
            const SizedBox(height: 16),
            
            // Live Tracking Section
            const Text(
              'Live Tracking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 12.0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Status Notifications
            const Text(
              'Status Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildStatusNotification(
              'Appointment Confirmed',
              'Your appointment with Dr. Smith at City Hospital is confirmed for 10:00 AM.',
              'View Details',
            ),
            _buildStatusNotification(
              'Ambulance Dispatched',
              'An ambulance has been dispatched and will arrive at your location in 15 minutes.',
              'Track Now',
            ),
            _buildStatusNotification(
              'Arrival Time',
              'Your ambulance is expected to arrive at 10:15 AM.',
              'Track Ambulance',
            ),
            const SizedBox(height: 16),
            
            // Reschedule and Cancel Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Cancel action
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black, // White text inside button
                  ),
                  child: Text('Cancel'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Reschedule action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, foregroundColor: Colors.white, // White text inside button
                  ),
                  child: const Text('Reschedule'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to build booking detail
  Widget _buildBookingDetail(IconData icon, String detail) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(detail),
    );
  }

  // Function to build status notifications with purple button and white text
  Widget _buildStatusNotification(String title, String detail, String buttonText) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(detail, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Set button color to purple
                foregroundColor: Colors.white, // White text inside button
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
