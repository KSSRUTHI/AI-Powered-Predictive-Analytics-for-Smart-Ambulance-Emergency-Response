import 'package:flutter/material.dart';

class OTAvailabilityPage extends StatefulWidget {
  const OTAvailabilityPage({super.key});

  @override
  State<OTAvailabilityPage> createState() => _OTAvailabilityPageState();
}

class _OTAvailabilityPageState extends State<OTAvailabilityPage> {
  final List<Map<String, int>> _surgeryTypes = [
    {'General Surgery': 1, 'Available': 0},
    {'Orthopedic Surgery': 1, 'Available': 0},
    {'Cardiothoracic Surgery': 0, 'Available': 1},
    {'Neurosurgery': 1, 'Available': 0},
    {'Obstetrics & Gynecology': 0, 'Available': 1},
    {'ENT Surgery': 0, 'Available': 1},
    {'Emergency Surgery': 1, 'Available': 0},
  ];

  void _editAvailability(int index) {
    final surgeryType = _surgeryTypes[index];
    final typeOfSurgery = surgeryType.keys.first;
    final occupied = surgeryType[typeOfSurgery]!;
    final available = surgeryType['Available']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController occupiedController = TextEditingController(text: occupied.toString());
        final TextEditingController availableController = TextEditingController(text: available.toString());

        return AlertDialog(
          title: Text('Edit Availability for $typeOfSurgery'),
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
                  _surgeryTypes[index] = {
                    typeOfSurgery: int.parse(occupiedController.text),
                    'Available': int.parse(availableController.text),
                  };
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
        title: const Text('OT Availability'),
      ),
      body: SingleChildScrollView(  // Wrap with SingleChildScrollView to prevent overflow
        scrollDirection: Axis.horizontal,  // Allow horizontal scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Type of Surgery',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DataTable(
                columnSpacing: 20,  // Increase the spacing between columns
                columns: const [
                  DataColumn(label: Text('Type of Surgery')),
                  DataColumn(label: Text('Occupied')),
                  DataColumn(label: Text('Available')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _surgeryTypes.asMap().entries.map((entry) {
                  final index = entry.key;
                  final surgeryType = entry.value;
                  final typeOfSurgery = surgeryType.keys.first;
                  final occupied = surgeryType[typeOfSurgery]!;
                  final available = surgeryType['Available']!;

                  return DataRow(
                    cells: [
                      DataCell(Text(typeOfSurgery)),
                      DataCell(Text(occupied.toString())),
                      DataCell(Text(available.toString())),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editAvailability(index),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
