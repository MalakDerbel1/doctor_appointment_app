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

  // Health conditions
  final List<String> _healthConditions = ['Yes', 'No'];
  String? _hasDiabetes;
  String? _hasHeartProblems;

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
        'Has Diabetes': _hasDiabetes ?? 'Not Selected',
        'Has Heart Problems': _hasHeartProblems ?? 'Not Selected',
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
        title: const Text('Patient Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Gender Radio Buttons
                        Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 10),
                            const Text('Gender'),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                value: 'Male',
                                groupValue: _selectedGender,
                                title: const Text('Male'),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                value: 'Female',
                                groupValue: _selectedGender,
                                title: const Text('Female'),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                value: 'Other',
                                groupValue: _selectedGender,
                                title: const Text('Other'),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                _buildHealthConditionRadio(
                  icon: Icons.warning_amber_rounded,
                  label: 'Diabetes',
                  value: _hasDiabetes,
                  onChanged: (value) {
                    setState(() {
                      _hasDiabetes = value;
                    });
                  },
                ),
                // Heart Problems Radio Buttons
                _buildHealthConditionRadio(
                  icon: Icons.favorite,
                  label: 'Heart Problems',
                  value: _hasHeartProblems,
                  onChanged: (value) {
                    setState(() {
                      _hasHeartProblems = value;
                    });
                  },
                ),
                // Height Field
                _buildInputField(
                  icon: Icons.height,
                  label: 'Height (in cm)',
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                ),
                // Weight Field
                _buildInputField(
                  icon: Icons.monitor_weight,
                  label: 'Weight (in kg)',
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                ),
                // Allergies Dropdown
                _buildDropdown(
                  icon: Icons.medical_services,
                  label: 'Allergies',
                  value: _selectedAllergy,
                  items: _allergyOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedAllergy = value;
                    });
                  },
                ),
                // Medical History Field
                _buildInputField(
                  icon: Icons.history_edu,
                  label: 'Medical History',
                  controller: _medicalHistoryController,
                  maxLines: 3,
                ),
                // Lifestyle Habits Field
                _buildInputField(
                  icon: Icons.health_and_safety,
                  label: 'Lifestyle Habits',
                  controller: _lifestyleController,
                  maxLines: 3,
                ),
                // Date of Visit Picker
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(
                    _selectedDate == null
                        ? 'Select Date of Visit'
                        : "Selected Date: ${_selectedDate!.toLocal()}"
                            .split(' ')[0],
                  ),
                  onTap: () => _selectDate(context),
                ),
                // Diabetes Radio Buttons

                const SizedBox(height: 20),
                // Submit Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.send),
                    label: const Text('Submit Information'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown({
    required IconData icon,
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildHealthConditionRadio({
    required IconData icon,
    required String label,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: _healthConditions.map((condition) {
                return Expanded(
                  child: RadioListTile<String>(
                    value: condition,
                    groupValue: value,
                    title: Text(condition),
                    onChanged: onChanged,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
