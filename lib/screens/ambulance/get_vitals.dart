import 'package:flutter/material.dart';

class GetVitals extends StatefulWidget {
  const GetVitals({super.key});

  @override
  _GetVitalsState createState() => _GetVitalsState();
}

class _GetVitalsState extends State<GetVitals> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _oxygenLevelsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _selectedGender;
  String? _selectedAgeRange;

  @override
  void dispose() {
    _heartRateController.dispose();
    _bloodPressureController.dispose();
    _oxygenLevelsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      final String ageRange = _selectedAgeRange ?? 'Not specified';
      final String gender = _selectedGender ?? 'Not specified';
      final int heartRate = int.parse(_heartRateController.text);
      final int bloodPressure = int.parse(_bloodPressureController.text);
      final int oxygenLevels = int.parse(_oxygenLevelsController.text);
      final String notes = _notesController.text;

      Navigator.pop(context, {
        'ageRange': ageRange,
        'gender': gender,
        'heartRate': heartRate,
        'bloodPressure': bloodPressure,
        'oxygenLevels': oxygenLevels,
        'notes': notes,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Patient Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Age Range Selection
              const Text('Age Range:'),
              const SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                value: _selectedAgeRange,
                items: <String>[
                  '0-18',
                  '19-35',
                  '36-60',
                  '61+'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAgeRange = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select an age range';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Gender Selection
              const Text('Gender:'),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Male'),
                      leading: Radio<String>(
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Female'),
                      leading: Radio<String>(
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Heart Rate
              TextFormField(
                controller: _heartRateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Heart Rate',
                  hintText: 'Enter heart rate (bpm)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the patient\'s heart rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Blood Pressure
              TextFormField(
                controller: _bloodPressureController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Blood Pressure',
                  hintText: 'Enter blood pressure (mmHg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the patient\'s blood pressure';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Oxygen Levels
              TextFormField(
                controller: _oxygenLevelsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Oxygen Levels',
                  hintText: 'Enter oxygen levels (%)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the patient\'s oxygen levels';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Nurse's Notes
              TextFormField(
                controller: _notesController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Nurse's Notes",
                  hintText: 'Enter additional comments or notes',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitDetails,
                  child: const Text('Submit Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
