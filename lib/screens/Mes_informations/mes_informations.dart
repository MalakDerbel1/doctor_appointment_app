import 'package:DocEase/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class PatientInformationForm extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;

  const PatientInformationForm({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(key: key);

  @override
  _PatientInformationFormState createState() => _PatientInformationFormState();
}

class _PatientInformationFormState extends State<PatientInformationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _lifestyleController = TextEditingController();

  // Gender radio button selection
  String? _selectedGender;

  // To store selected date and time
  DateTime? _selectedDate;

  // Allergy options
  List<String> _allergyOptions = ['Peanuts', 'Shellfish', 'Penicillin', 'None'];
  String? _selectedAllergy;

  // Function to pick date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to submit the form
  // PatientInformationForm.dart

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final patientInfo = {
        'Gender': _selectedGender,
        'Height': _heightController.text,
        'Weight': _weightController.text,
        'Allergies': _selectedAllergy ?? 'No allergies selected',
        'Medical History': _medicalHistoryController.text,
        'Lifestyle': _lifestyleController.text,
        'Date of Visit': _selectedDate != null
            ? "${_selectedDate!.toLocal()}".split(' ')[0]
            : 'Not Selected',
      };

      // Navigate to ProfileScreen and pass the form data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            firstName: widget.firstName, // Pass real data
            lastName: widget.lastName, // Pass real data
            email: widget.email, // Pass real data
            patientInfo: patientInfo, // Pass the collected patient info
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Gender Radio Buttons
                ListTile(
                  title: Text('Gender'),
                  subtitle: Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      Text('Female'),
                      Radio<String>(
                        value: 'Other',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      Text('Other'),
                    ],
                  ),
                ),
                // Height Field
                TextFormField(
                  controller: _heightController,
                  decoration: InputDecoration(labelText: 'Height (in cm)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter height';
                    }
                    return null;
                  },
                ),
                // Weight Field
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight (in kg)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter weight';
                    }
                    return null;
                  },
                ),
                // Allergies Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedAllergy,
                  decoration: InputDecoration(labelText: 'Allergies'),
                  items: _allergyOptions
                      .map((allergy) => DropdownMenuItem<String>(
                            value: allergy,
                            child: Text(allergy),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAllergy = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an allergy';
                    }
                    return null;
                  },
                ),
                // Medical History Field
                TextFormField(
                  controller: _medicalHistoryController,
                  decoration: InputDecoration(labelText: 'Medical History'),
                ),
                // Lifestyle Habits Field
                TextFormField(
                  controller: _lifestyleController,
                  decoration: InputDecoration(labelText: 'Lifestyle Habits'),
                ),
                // Date of Visit Picker
                ListTile(
                  title: Text(
                    _selectedDate == null
                        ? 'Select Date of Visit'
                        : "Selected Date: ${_selectedDate!.toLocal()}"
                            .split(' ')[0],
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 20),
                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit Information'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
