// notification_model.dart

class NotificationModel {
  final String id; // Unique identifier for the notification
  final String message; // The content or message of the notification
  final DateTime timestamp; // When the notification was created
  final bool isRead; // Whether the notification has been read
  final double latitude; // Latitude of the hospital or relevant location
  final double longitude; // Longitude of the hospital or relevant location

  // Constructor
  NotificationModel({
    required this.id,
    required this.message,
    required this.timestamp,
    this.isRead = false, // Default value for isRead is false
    required this.latitude,
    required this.longitude,
  });

  // Optional: Method to convert a Notification instance to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Optional: Method to create a Notification instance from a Map (for JSON deserialization)
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
