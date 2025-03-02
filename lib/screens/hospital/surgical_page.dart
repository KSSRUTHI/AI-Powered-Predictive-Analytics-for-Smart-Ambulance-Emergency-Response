import 'package:flutter/material.dart';

class SurgicalEquipmentsPage extends StatefulWidget {
  const SurgicalEquipmentsPage({super.key});

  @override
  State<SurgicalEquipmentsPage> createState() => _SurgicalEquipmentsPageState();
}

class _SurgicalEquipmentsPageState extends State<SurgicalEquipmentsPage> {
  final List<String> _equipments = [
    'Surgical Table',
    'Electrosurgical Unit (ESU)',
    'Anesthesia Machine',
    'Surgical Lights',
    'Sterilizer (Autoclave)',
    'Surgical Instruments Set',
    'Laparoscope',
    'Electrocardiograph (ECG)',
    'Defibrillator',
    'Surgical Drills',
  ];

  final TextEditingController _newEquipmentController = TextEditingController();

  void _addEquipment() {
    final newEquipment = _newEquipmentController.text.trim();
    if (newEquipment.isNotEmpty) {
      setState(() {
        _equipments.add(newEquipment);
        _newEquipmentController.clear();
      });
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  void _removeEquipment(String equipment) {
    setState(() {
      _equipments.remove(equipment);
    });
  }

  void _showAddEquipmentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Equipment'),
          content: TextField(
            controller: _newEquipmentController,
            decoration: const InputDecoration(
              labelText: 'Enter equipment name',
              border: OutlineInputBorder(),
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
              onPressed: _addEquipment,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showRemoveEquipmentDialog(String equipment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Equipment'),
          content: Text('Are you sure you want to remove "$equipment"?'),
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
                _removeEquipment(equipment);
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
        title: const Text('Surgical Equipments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Surgical Equipments',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _equipments.length,
                itemBuilder: (context, index) {
                  final equipment = _equipments[index];
                  return ListTile(
                    title: Text(equipment),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _showRemoveEquipmentDialog(equipment),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
              child: ElevatedButton(
                onPressed: _showAddEquipmentDialog,
                child: const Text('ADD NEW EQUIPMENT'),
              ),
            ),
               
              ],
            ),
          ],
        ),
      ),
    );
  }
}
