import 'package:flutter/material.dart';

class PatientVitalSubmission extends StatefulWidget {
  const PatientVitalSubmission({super.key});

  @override
  _PatientVitalSubmissionState createState() => _PatientVitalSubmissionState();
}

class _PatientVitalSubmissionState extends State<PatientVitalSubmission> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _oxygenLevelsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool _isCriticalCondition = false;
  String? _selectedGender;
  String? _selectedAgeRange;
  final Map<String, bool> _selectedHospitals = {
    'Hospital A': false,
    'Hospital B': false,
    'Hospital C': false,
  };

  // Clean up controllers when widget is disposed
  @override
  void dispose() {
    _heartRateController.dispose();
    _bloodPressureController.dispose();
    _oxygenLevelsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitVitals() {
    if (_formKey.currentState!.validate()) {
      // Show a Snackbar with submission feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting Vitals...')),
      );

      // Capture form data and perform submission logic (e.g., API call)
      final String ageRange = _selectedAgeRange ?? 'Not specified';
      final String gender = _selectedGender ?? 'Not specified';
      final int heartRate = int.parse(_heartRateController.text);
      final int bloodPressure = int.parse(_bloodPressureController.text);
      final int oxygenLevels = int.parse(_oxygenLevelsController.text);
      final String notes = _notesController.text;
      final bool criticalCondition = _isCriticalCondition;
      final List<String> selectedHospitals = _selectedHospitals.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      // Log data for demonstration (replace with API call or other logic)
      print("Age Range: $ageRange, Gender: $gender");
      print("Heart Rate: $heartRate, Blood Pressure: $bloodPressure, Oxygen Levels: $oxygenLevels");
      print("Critical Condition: $criticalCondition, Notes: $notes");
      print("Selected Hospitals: $selectedHospitals");

      // After form submission, you can reset or navigate away
      _formKey.currentState!.reset();
      setState(() {
        _isCriticalCondition = false;
        _selectedGender = null;
        _selectedAgeRange = null;
        _selectedHospitals.updateAll((key, value) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Vital Submission'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),

              // Age Range Selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Age Range',
                  border: OutlineInputBorder(),
                ),
                value: _selectedAgeRange,
                items: <String>[
                  '0-10',
                  '11-20',
                  '21-30',
                  '31-40',
                  '41-50',
                  '51-60',
                  '61-70',
                  '71+',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an age range';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Gender Selection
              Row(
                children: [
                  const Text('Gender:'),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Critical Condition Checkbox
              CheckboxListTile(
                title: const Text('Critical Condition'),
                value: _isCriticalCondition,
                onChanged: (value) {
                  setState(() {
                    _isCriticalCondition = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Vital Signs
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

              // Select Hospitals
              const Text('Select Hospitals:'),
              ..._selectedHospitals.keys.map((hospital) {
                return CheckboxListTile(
                  title: Text(hospital),
                  value: _selectedHospitals[hospital],
                  onChanged: (value) {
                    setState(() {
                      _selectedHospitals[hospital] = value!;
                    });
                  },
                );
              }),
              const SizedBox(height: 16.0),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitVitals,
                  child: const Text('Submit Vitals'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
