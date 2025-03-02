import 'package:flutter/material.dart';
// lib/models/category.dart


class AddCategoryPage extends StatefulWidget {
  final void Function(Category) onCategoryAdded;

  const AddCategoryPage({super.key, required this.onCategoryAdded});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submit() {
    final name = _nameController.text;
    final description = _descriptionController.text;

    if (name.isNotEmpty && description.isNotEmpty) {
      widget.onCategoryAdded(Category(name, description)); // Ensure correct type
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both name and description')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Category'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Category Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final String description;

  Category(this.name, this.description);
}
