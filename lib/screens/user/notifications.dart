import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationCardData> notifications = [
    NotificationCardData(
      title: 'New Message',
      subtitle: 'You have received a new message from Dr. Smith regarding your appointment.',
      timeAgo: 'Just now',
      icon: Icons.local_hospital,
      isRead: false,
    ),
    NotificationCardData(
      title: 'Appointment Reminder',
      subtitle: 'Don’t forget your appointment with Dr. Smith at 10:00 AM tomorrow.',
      timeAgo: '5 minutes ago',
      icon: Icons.circle,
      isRead: false,
    ),
    NotificationCardData(
      title: 'Doctor On-Call',
      subtitle: 'Dr. Smith is now on-call for emergency cases',
      timeAgo: '20 minutes ago',
      icon: Icons.circle,
      isRead: false,
    ),
    NotificationCardData(
      title: 'Emergency Alert',
      subtitle: 'An emergency alert has been issued in your area. Stay safe and follow instructions.',
      timeAgo: '30 minutes ago',
      icon: Icons.build,
      isRead: true,
    ),
    NotificationCardData(
      title: 'Health Tips',
      subtitle: 'Check out the latest health tips and recommendations.',
      timeAgo: '2 hours ago',
      icon: Icons.circle,
      isRead: true,
    ),
  ];

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton.icon(
            onPressed: markAllAsRead,
            icon: const Icon(Icons.check),
            label: const Text(
              'Mark All as Read',
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
      body: ListView(
        children: notifications.map((notification) {
          return NotificationCard(
            title: notification.title,
            subtitle: notification.subtitle,
            timeAgo: notification.timeAgo,
            icon: notification.icon,
            isRead: notification.isRead,
          );
        }).toList(),
      ),
    );
  }
}

class NotificationCardData {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  bool isRead;

  NotificationCardData({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    this.isRead = false,
  });
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final bool isRead;

  const NotificationCard({super.key, 
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              child: Icon(icon),
            ),
            if (!isRead)
              const Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 12,
                ),
              ),
          ],
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(timeAgo),
      ),
    );
  }
}
