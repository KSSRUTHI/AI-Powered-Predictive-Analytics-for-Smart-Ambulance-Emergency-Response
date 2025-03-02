import 'package:flutter/material.dart';

class SubmitVitals extends StatefulWidget {
  const SubmitVitals({super.key});

  @override
  _SubmitVitalsState createState() => _SubmitVitalsState();
}

class _SubmitVitalsState extends State<SubmitVitals> {
  final _formKey = GlobalKey<FormState>();

  // Sample patient details including vitals
  final Map<String, dynamic> _samplePatientDetails = {
    'age': 45,
    'gender': 'Male',
    'id': '123456',
    'heartRate': 75,
    'bloodPressure': '120/80',
    'oxygenLevels': 98,
    'nurseNotes': 'Patient is stable. Monitor heart rate for fluctuations.'
  };

  bool _isCriticalCondition = false;
  final Map<String, bool> _selectedHospitals = {
    'Hospital A': false,
    'Hospital B': false,
    'Hospital C': false,
  };

  // Age value
  int _selectedAge = 45;

  // Function to handle form submission
  void _submitVitals() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vitals Submitted')),
      );

      final bool criticalCondition = _isCriticalCondition;
      final List<String> selectedHospitals = _selectedHospitals.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      // Log the selected data for demonstration (you can replace this with an API call or other logic)
      print("Critical Condition: $criticalCondition");
      print("Selected Hospitals: $selectedHospitals");

      setState(() {
        _isCriticalCondition = false;
        _selectedHospitals.updateAll((key, value) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Vitals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display patient details
              Text(
                'Patient Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              _buildDetailRow('Age:', _selectedAge.toString()),
              _buildDetailRow('Gender:', _samplePatientDetails['gender']),
              _buildDetailRow('Patient ID:', _samplePatientDetails['id']),
              const SizedBox(height: 16.0),

              // Display vital signs
              Text(
                'Vital Signs',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              _buildDetailRow('Heart Rate:', '${_samplePatientDetails['heartRate']} bpm'),
              _buildDetailRow('Blood Pressure:', _samplePatientDetails['bloodPressure']),
              _buildDetailRow('Oxygen Levels:', '${_samplePatientDetails['oxygenLevels']} %'),
              _buildDetailRow('Nurse\'s Notes:', _samplePatientDetails['nurseNotes']),
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

              // Age Input (using DropdownButtonFormField)
              const Text('Select Age:'),
              DropdownButtonFormField<int>(
                value: _selectedAge,
                items: List.generate(100, (index) {
                  final age = index + 1;
                  return DropdownMenuItem<int>(
                    value: age,
                    child: Text(age.toString()),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _selectedAge = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value < 1 || value > 120) {
                    return 'Please select a valid age (1-120)';
                  }
                  return null;
                },
              ),
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

  // Helper function to create a formatted detail row with larger font sizes
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Increased font size for label
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16), // Increased font size for value
            ),
          ),
        ],
      ),
    );
  }
}
