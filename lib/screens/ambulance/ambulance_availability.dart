import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class AmbulanceAvailabilityScreen extends StatefulWidget {
  const AmbulanceAvailabilityScreen({super.key});

  @override
  State<AmbulanceAvailabilityScreen> createState() => _AmbulanceAvailabilityScreenState();
}

class _AmbulanceAvailabilityScreenState extends State<AmbulanceAvailabilityScreen> {
  bool isAmbulanceAvailable = true;
  DateTime? startDate;
  DateTime? endDate;

  final DateFormat _dateFormat = DateFormat('MM/dd/yyyy'); // Define the date format

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambulance Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ambulance Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAmbulanceAvailable = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAmbulanceAvailable ? Colors.green : Colors.grey,
                  ),
                  child: const Text('AVAILABLE'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAmbulanceAvailable = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isAmbulanceAvailable ? Colors.red : Colors.grey,
                  ),
                  child: const Text('UNAVAILABLE'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Current Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              isAmbulanceAvailable ? 'Available' : 'Unavailable',
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Last Updated:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_getLastUpdatedTime()),
            const SizedBox(height: 32.0),
            const Text(
              'Schedule Maintenance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Start Date',
              ),
              readOnly: true,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: startDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  setState(() {
                    startDate = pickedDate;
                  });
                }
              },
              controller: TextEditingController(text: startDate != null ? _dateFormat.format(startDate!) : ''),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'End Date',
              ),
              readOnly: true,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: endDate ?? startDate ?? DateTime.now(),
                  firstDate: startDate ?? DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  setState(() {
                    endDate = pickedDate;
                  });
                }
              },
              controller: TextEditingController(text: endDate != null ? _dateFormat.format(endDate!) : ''),
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle "EDIT" button logic
                    setState(() {
                      // Allow changes to the date fields or other fields
                    });
                  },
                  child: const Text('EDIT'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle "SAVE" button logic
                    // Save the changes or send data to the server
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Changes saved successfully!'),
                      ),
                    );
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getLastUpdatedTime() {
    // Replace this with actual logic to get the last updated time
    return DateFormat('hh:mm a').format(DateTime.now());
  }
}
