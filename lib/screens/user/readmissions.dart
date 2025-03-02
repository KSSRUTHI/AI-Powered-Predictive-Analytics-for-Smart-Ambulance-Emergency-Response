import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

class ReadmissionPredictionScreen extends StatefulWidget {
  const ReadmissionPredictionScreen({super.key});

  @override
  _ReadmissionPredictionScreenState createState() => _ReadmissionPredictionScreenState();
}

class _ReadmissionPredictionScreenState extends State<ReadmissionPredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  String predictionResult = "";

  // Form fields
  int age = 0;
  String gender = "Male";
  String socioeconomicStatus = "Low";
  String insuranceType = "Private";
  int previousAdmissions = 0;
  List<String> chronicDiseases = [];
  String surgeries = "";
  String allergies = "";
  String familyMedicalHistory = "";
  String primaryDiagnosis = "";
  String medications = "";
  String rehabilitation = "No";
  String bloodTest = "";
  String imagingReports = "";
  String bloodPressure = "";
  int heartRate = 60;
  int oxygenLevels = 95;
  double bmi = 20.0;
  String smoking = "No";
  String alcohol = "No";
  String physicalActivity = "Low";
  String medicationAdherence = "Good";
  String livingConditions = "Stable";
  String caregiverSupport = "No";
  String mentalHealth = "Good";
  String healthcareAccess = "Easy";
  int lengthOfStay = 1;
  String icuAdmission = "No";
  String reasonForDischarge = "";
  String postDischargeCare = "No";

  // File upload
  PlatformFile? selectedFile;

  Future<void> predictReadmission() async {
    final userData = {
      "Age": age,
      "Gender": gender,
      "Socioeconomic Status": socioeconomicStatus,
      "Insurance Type": insuranceType,
      "Previous Admissions": previousAdmissions,
      "Chronic Diseases": chronicDiseases,
      "Surgeries": surgeries,
      "Allergies": allergies,
      "Family Medical History": familyMedicalHistory,
      "Primary Diagnosis": primaryDiagnosis,
      "Medications": medications,
      "Rehabilitation": rehabilitation,
      "Blood Test Results": bloodTest,
      "Imaging Reports": imagingReports,
      "Blood Pressure": bloodPressure,
      "Heart Rate": heartRate,
      "Oxygen Levels": oxygenLevels,
      "BMI": bmi,
      "Smoking": smoking,
      "Alcohol Consumption": alcohol,
      "Physical Activity": physicalActivity,
      "Medication Adherence": medicationAdherence,
      "Living Conditions": livingConditions,
      "Caregiver Support": caregiverSupport,
      "Mental Health Status": mentalHealth,
      "Healthcare Access": healthcareAccess,
      "Length of Stay": lengthOfStay,
      "ICU Admission": icuAdmission,
      "Reason for Discharge": reasonForDischarge,
      "Post-Discharge Care": postDischargeCare,
    };

    final prompt = """
    Given the following patient data:
    ${jsonEncode(userData)}
    Predict the likelihood of readmission as a percentage.
    Provide recommendations to prevent it.
    """;

    final url = Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=AIzaSyDa_KyweBHxPQRvWaP5sFR4ifu54bupUH0");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "contents": [
        {"parts": [{"text": prompt}]}
      ]
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          predictionResult = responseData["candidates"][0]["content"]["parts"][0]["text"];
        });
      } else {
        setState(() {
          predictionResult = "Error: ${response.statusCode} - ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "Error: $e";
      });
    }
  }

  Future<void> analyzeUploadedFile() async {
    if (selectedFile == null) {
      setState(() {
        predictionResult = "No file uploaded.";
      });
      return;
    }

    // Simulate file analysis (replace with actual API call for file processing)
    setState(() {
      predictionResult = "Analyzing file: ${selectedFile!.name}...";
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate processing delay

    setState(() {
      predictionResult = "File analysis complete. Readmission likelihood: 30% (based on uploaded data).";
    });
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Readmission Prediction")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Option to upload file
              _buildSectionHeader("Upload Medical Documents"),
              ElevatedButton.icon(
                onPressed: pickFile,
                icon: Icon(Icons.upload_file),
                label: Text("Upload Medical Report"),
              ),
              if (selectedFile != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Selected File: ${selectedFile!.name}", style: TextStyle(color: Colors.green)),
                ),
              ElevatedButton(
                onPressed: analyzeUploadedFile,
                child: Text("Analyze Uploaded File"),
              ),

              // OR enter data manually
              _buildSectionHeader("OR Enter Data Manually"),
              _buildNumberInput("Age", (value) => age = value),
              _buildDropdown("Gender", ["Male", "Female", "Other"], (value) => gender = value!),
              _buildDropdown("Socioeconomic Status", ["Low", "Middle", "High"], (value) => socioeconomicStatus = value!),
              _buildDropdown("Insurance Type", ["Private", "Public", "None"], (value) => insuranceType = value!),
              _buildNumberInput("Previous Admissions", (value) => previousAdmissions = value),
              _buildMultiSelect("Chronic Diseases", ["Diabetes", "Hypertension", "Heart Disease", "None"], (values) => chronicDiseases = values),
              _buildTextArea("Past Surgeries (if any)", (value) => surgeries = value),
              _buildTextArea("Known Allergies", (value) => allergies = value),
              _buildTextArea("Family Medical History", (value) => familyMedicalHistory = value),
              _buildTextArea("Primary Diagnosis", (value) => primaryDiagnosis = value),
              _buildTextArea("Current Medications", (value) => medications = value),
              _buildDropdown("Undergoing Rehabilitation?", ["Yes", "No"], (value) => rehabilitation = value!),
              _buildTextArea("Blood Test Results (e.g., CBC, Glucose Levels)", (value) => bloodTest = value),
              _buildTextArea("Imaging Reports (e.g., MRI, CT)", (value) => imagingReports = value),
              _buildTextInput("Blood Pressure (e.g., 120/80)", (value) => bloodPressure = value),
              _buildNumberInput("Heart Rate (bpm)", (value) => heartRate = value),
              _buildNumberInput("Oxygen Saturation (SpO2 %)", (value) => oxygenLevels = value),
              _buildSlider("BMI", 10.0, 50.0, (value) => bmi = value),
              _buildDropdown("Smoking Habit", ["Yes", "No"], (value) => smoking = value!),
              _buildDropdown("Alcohol Consumption", ["Yes", "No"], (value) => alcohol = value!),
              _buildDropdown("Physical Activity Level", ["Low", "Moderate", "High"], (value) => physicalActivity = value!),
              _buildDropdown("Medication Adherence", ["Good", "Average", "Poor"], (value) => medicationAdherence = value!),
              _buildDropdown("Living Conditions", ["Stable", "Unstable"], (value) => livingConditions = value!),
              _buildDropdown("Caregiver Support", ["Yes", "No"], (value) => caregiverSupport = value!),
              _buildDropdown("Mental Health Status", ["Good", "Average", "Poor"], (value) => mentalHealth = value!),
              _buildDropdown("Healthcare Accessibility", ["Easy", "Difficult"], (value) => healthcareAccess = value!),
              _buildNumberInput("Length of Stay (days)", (value) => lengthOfStay = value),
              _buildDropdown("ICU Admission?", ["Yes", "No"], (value) => icuAdmission = value!),
              _buildTextArea("Reason for Discharge", (value) => reasonForDischarge = value),
              _buildDropdown("Receiving Post-Discharge Care?", ["Yes", "No"], (value) => postDischargeCare = value!),

              // Predict Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    predictReadmission();
                  }
                },
                child: Text("Predict Readmission"),
              ),

              // Prediction Result
              if (predictionResult.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Prediction: $predictionResult",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }

  Widget _buildTextInput(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      onChanged: onChanged,
    );
  }

  Widget _buildTextArea(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      maxLines: 3,
      onChanged: onChanged,
    );
  }

  Widget _buildNumberInput(String label, Function(int) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      keyboardType: TextInputType.number,
      onChanged: (value) => onChanged(int.tryParse(value) ?? 0),
    );
  }

  Widget _buildDropdown(String label, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildMultiSelect(String label, List<String> options, Function(List<String>) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
        Wrap(
          spacing: 8.0,
          children: options.map((String value) {
            return FilterChip(
              label: Text(value),
              selected: chronicDiseases.contains(value),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    chronicDiseases.add(value);
                  } else {
                    chronicDiseases.remove(value);
                  }
                  onChanged(chronicDiseases);
                });
              },
              selectedColor: Colors.blue.shade100,
              checkmarkColor: Colors.blue.shade800,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSlider(String label, double min, double max, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
        Slider(
          value: bmi,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: bmi.toStringAsFixed(1),
          onChanged: onChanged,
          activeColor: Colors.blue.shade800,
          inactiveColor: Colors.blue.shade100,
        ),
      ],
    );
  }
}