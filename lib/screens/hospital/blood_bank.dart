import 'package:flutter/material.dart';

class BloodBankAvailabilityPage extends StatefulWidget {
  const BloodBankAvailabilityPage({super.key});

  @override
  State<BloodBankAvailabilityPage> createState() =>
      _BloodBankAvailabilityPageState();
}

class _BloodBankAvailabilityPageState
    extends State<BloodBankAvailabilityPage> {
  final List<Map<String, int>> _bloodTypes = [
    {'O+': 10},
    {'O-': 6},
    {'A+': 8},
    {'A-': 4},
    {'B+': 7},
    {'B-': 3},
    {'AB+': 3},
    {'AB-': 2},
  ];

  void _editUnits(int index) {
    final bloodType = _bloodTypes[index];
    final bloodTypeKey = bloodType.keys.first;
    final currentUnits = bloodType[bloodTypeKey] ?? 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController unitsController =
            TextEditingController(text: currentUnits.toString());

        return AlertDialog(
          title: Text('Edit Units for $bloodTypeKey'),
          content: SingleChildScrollView(
            child: TextField(
              controller: unitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter new number of units',
                border: OutlineInputBorder(),
              ),
            ),
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
                final newUnits =
                    int.tryParse(unitsController.text) ?? currentUnits;
                setState(() {
                  _bloodTypes[index] = {bloodTypeKey: newUnits};
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
        title: const Text('Blood Bank Availability'),
      ),
      resizeToAvoidBottomInset: true,  // Ensures layout adjusts when keyboard is open
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blood Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 50.0, // Adjust column spacing to avoid overlap
                columns: const [
                  DataColumn(label: Text('Blood Type')),
                  DataColumn(label: Text('Units Donated')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _bloodTypes.map((bloodType) {
                  final bloodTypeKey = bloodType.keys.first;
                  final unitsDonated = bloodType[bloodTypeKey] ?? 0;

                  return DataRow(
                    cells: [
                      DataCell(Text(bloodTypeKey)),
                      DataCell(Text(unitsDonated.toString())),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editUnits(_bloodTypes.indexOf(bloodType)),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
