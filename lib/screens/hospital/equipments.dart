import 'package:flutter/material.dart';
import 'package:flutter_app/screens/hospital/diagnostic_page.dart';
import 'package:flutter_app/screens/hospital/monitoring_page.dart';
import 'package:flutter_app/screens/hospital/new_category.dart';
import 'package:flutter_app/screens/hospital/surgical_page.dart';

// lib/models/category.dart



class EquipmentsPage extends StatefulWidget {
  const EquipmentsPage({super.key});

  @override
  State<EquipmentsPage> createState() => _EquipmentsPageState();
}

class _EquipmentsPageState extends State<EquipmentsPage> {
  final List<Category> _categories = [
    Category('Diagnostics', 'Equipments used for diagnostics purposes.'),
    Category('Surgical', 'Equipments used during surgical operations.'),
    Category('Monitoring', 'Equipments used for patient monitoring.'),
  ];

  void _addCategory(Category category) {
    setState(() {
      _categories.add(category);
    });
  }

  void _removeCategory(Category category) {
    setState(() {
      _categories.remove(category);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${category.name} removed')),
    );
  }

  void _navigateToPage(String category) {
    Widget page;
    switch (category) {
      case 'Diagnostics':
        page = const DiagnosticEquipmentsPage();
        break;
      case 'Surgical':
        page = const SurgicalEquipmentsPage();
        break;
      case 'Monitoring':
        page = const MonitoringEquipmentsPage();
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipments'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Equipments Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(category.name),
                      subtitle: Text(category.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeCategory(category),
                      ),
                      onTap: () => _navigateToPage(category.name),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCategoryPage(
                        onCategoryAdded: _addCategory,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('ADD NEW CATEGORY'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
