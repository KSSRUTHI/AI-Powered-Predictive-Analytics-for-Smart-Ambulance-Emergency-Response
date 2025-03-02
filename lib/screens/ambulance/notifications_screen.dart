import 'package:flutter/material.dart';
import 'package:flutter_app/screens/ambulance/navigation_page.dart';
import 'notification_model.dart'; // Ensure the path is correct

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Use NotificationModel instead of Notification
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      message: 'City hospital has accepted the request. Tap to Navigate to the Hospital',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      latitude: 37.7749, // Example latitude
      longitude: -122.4194, // Example longitude
    ),
    NotificationModel(
      id: '2',
      message: 'Patient Jane Smith has been handed over. Review the details.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      latitude: 34.0522, // Example latitude
      longitude: -118.2437, // Example longitude
    ),
    // Add more notifications as needed
  ];

  void _handleNotificationTap(NotificationModel notification) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>const HospitalNavigationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            leading: Icon(
              notification.id == '1' ? Icons.local_hospital : Icons.info,
              color: notification.id == '1' ? Colors.green : Colors.blue,
            ),
            title: Text(notification.message),
            subtitle: Text('${notification.timestamp}'),
            trailing: notification.id == '1'
                ? const CircleAvatar(
                    radius: 10.0,
                    backgroundColor: Colors.red,
                    child: Text(
                      '!',
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  )
                : null,
            onTap: () => _handleNotificationTap(notification),
          );
        },
      ),
    );
  }
}
