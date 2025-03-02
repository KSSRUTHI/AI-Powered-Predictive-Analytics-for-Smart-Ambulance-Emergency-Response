import 'package:flutter/material.dart';

class PatientVitalsScreen extends StatefulWidget {
  const PatientVitalsScreen({super.key});

  @override
  _PatientVitalsScreenState createState() => _PatientVitalsScreenState();
}

class _PatientVitalsScreenState extends State<PatientVitalsScreen> {
  bool bloodPressureSelected = false;
  bool heartRateSelected = false;
  bool oxygenSaturationSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Vitals'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Help action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vital Signs Inputs
            const Text(
              'Vital Signs Inputs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildVitalInput('Blood Pressure', () {
              setState(() {
                bloodPressureSelected = !bloodPressureSelected;
              });
            }, bloodPressureSelected),
            _buildVitalInput('Heart Rate', () {
              setState(() {
                heartRateSelected = !heartRateSelected;
              });
            }, heartRateSelected),
            _buildVitalInput('Oxygen Saturation', () {
              setState(() {
                oxygenSaturationSelected = !oxygenSaturationSelected;
              });
            }, oxygenSaturationSelected),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Send selected vitals to hospital
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white, // Text color set to white
              ),
              child: const Text('Send to Hospital'),
            ),
            const SizedBox(height: 16),
            // Real-Time Vitals
            const Text(
              'Real-Time Vitals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildRealTimeVitals('Blood Pressure: 120/80 mmHg - Last updated: 2 mins ago'),
            _buildRealTimeVitals('Heart Rate: 72 bpm - Last updated: 1 min ago'),
            _buildRealTimeVitals('Oxygen Saturation: 98% - Last updated: 3 mins ago'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Send real-time vitals to hospital
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white, // Text color set to white
              ),
              child: const Text('Send to Hospital'),
            ),
            const SizedBox(height: 16),
            // Patient Information Section
            const Text(
              'Patient Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildPatientInfoCard(
                    'Allergies',
                    'Patient is allergic to penicillin and sulfur drugs.',
                    'Send to Hospital',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPatientInfoCard(
                    'Medical History',
                    'History of asthma and hypertension. No recent surgeries.',
                    'Send to Hospital',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Final action: send all data to the hospital
              },
              icon: const Icon(Icons.local_hospital),
              label: const Text('Send to Hospital'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white, // Text color set to white
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Vital Input Checkbox
  Widget _buildVitalInput(String label, VoidCallback onTap, bool selected) {
    return ListTile(
      leading: Checkbox(
        value: selected,
        onChanged: (value) {
          onTap();
        },
      ),
      title: Text(label),
    );
  }

  // Build Real-Time Vitals Display
  Widget _buildRealTimeVitals(String data) {
    return ListTile(
      leading: Checkbox(
        value: true, // Real-time vitals are always true for this display.
        onChanged: (value) {},
      ),
      title: Text(data),
    );
  }

  // Build Patient Information Cards
  Widget _buildPatientInfoCard(String title, String info, String buttonLabel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(info),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Send patient info to hospital
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white, // Text color set to white
              ),
              child: Text(buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
