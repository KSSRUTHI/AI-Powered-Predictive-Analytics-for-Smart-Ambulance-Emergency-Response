import 'package:flutter/material.dart';

// Define a ScanType model class
class ScanType {
  String type;
  int occupied;
  int available;

  ScanType({
    required this.type,
    required this.occupied,
    required this.available,
  });
}

class ScanAvailabilityPage extends StatefulWidget {
  const ScanAvailabilityPage({super.key});

  @override
  State<ScanAvailabilityPage> createState() => _ScanAvailabilityPageState();
}

class _ScanAvailabilityPageState extends State<ScanAvailabilityPage> {
  // Refactored list using the ScanType class
  final List<ScanType> _scanTypes = [
    ScanType(type: 'Chest X-Ray', occupied: 2, available: 3),
    ScanType(type: 'Abdominal X-Ray', occupied: 1, available: 2),
    ScanType(type: 'Bone X-Ray', occupied: 3, available: 1),
    ScanType(type: 'Dental X-Ray', occupied: 1, available: 1),
    ScanType(type: 'Mammography', occupied: 1, available: 2),
    ScanType(type: 'Fluoroscopy', occupied: 2, available: 1),
    ScanType(type: 'Portable X-Ray', occupied: 2, available: 1),
  ];

  // Function to add a new scan type
  void _addScan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController scanTypeController = TextEditingController();
        final TextEditingController occupiedController = TextEditingController();
        final TextEditingController availableController = TextEditingController();

        return AlertDialog(
          title: const Text('Add New Scan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: scanTypeController,
                decoration: const InputDecoration(labelText: 'Scan Type'),
              ),
              TextField(
                controller: occupiedController,
                decoration: const InputDecoration(labelText: 'Occupied'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: availableController,
                decoration: const InputDecoration(labelText: 'Available'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  _scanTypes.add(
                    ScanType(
                      type: scanTypeController.text,
                      occupied: int.parse(occupiedController.text),
                      available: int.parse(availableController.text),
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to edit an existing scan type
  void _editScan(int index) {
    final scanType = _scanTypes[index];
    final TextEditingController occupiedController =
        TextEditingController(text: scanType.occupied.toString());
    final TextEditingController availableController =
        TextEditingController(text: scanType.available.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Availability for ${scanType.type}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: occupiedController,
                decoration: const InputDecoration(labelText: 'Occupied'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: availableController,
                decoration: const InputDecoration(labelText: 'Available'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _scanTypes[index].occupied = int.parse(occupiedController.text);
                  _scanTypes[index].available = int.parse(availableController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to remove a scan type
  void _removeScan(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Scan'),
          content: const Text('Are you sure you want to remove this scan?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Remove'),
              onPressed: () {
                setState(() {
                  _scanTypes.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'X-Ray Scan Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 40.0,
                columns: const [
                  DataColumn(label: Text('Scan Type')),
                  DataColumn(label: Text('Occupied')),
                  DataColumn(label: Text('Available')),
                  DataColumn(label: Text('Edit Scan')),
                  DataColumn(label: Text('Remove Scan')),
                ],
                rows: _scanTypes.asMap().entries.map((entry) {
                  final index = entry.key;
                  final scanType = entry.value;

                  return DataRow(
                    cells: [
                      DataCell(Text(scanType.type)),
                      DataCell(Text(scanType.occupied.toString())),
                      DataCell(Text(scanType.available.toString())),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editScan(index),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeScan(index),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addScan,
              child: const Text('ADD NEW SCANS'),
            ),
          ],
        ),
      ),
    );
  }
}
