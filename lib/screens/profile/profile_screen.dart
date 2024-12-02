import 'package:DocEase/screens/auth_screens/login_screen/login_screen.dart';
import 'package:DocEase/utils/themes/color_themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final Map<String, dynamic> patientInfo;

  const ProfileScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.patientInfo,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> patientInfo;

  @override
  void initState() {
    super.initState();
    patientInfo = {
      'Gender': 'N/A',
      'Allergies': 'N/A',
      'Has Diabetes': 'N/A',
      'Has Heart Problems': 'N/A',
      'Height': 'N/A',
      'Weight': 'N/A',
      'Has Fever': 'N/A',
    };
    _loadPatientInfo();
  }

  Future<void> _loadPatientInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('patientInfo');
    if (savedData != null) {
      setState(() {
        patientInfo = json.decode(savedData);
        // Ensure all fields are populated with a fallback value if they are missing
        patientInfo.putIfAbsent('Gender', () => 'N/A');
        patientInfo.putIfAbsent('Allergies', () => 'N/A');
        patientInfo.putIfAbsent('Has Diabetes', () => 'N/A');
        patientInfo.putIfAbsent('Has Heart Problems', () => 'N/A');
        patientInfo.putIfAbsent('Height', () => 'N/A');
        patientInfo.putIfAbsent('Weight', () => 'N/A');
        patientInfo.putIfAbsent('Has Fever', () => 'N/A');
      });
    } else {
      setState(() {
        patientInfo = Map<String, dynamic>.from(widget.patientInfo);
      });
    }
  }

  Future<void> _savePatientInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('patientInfo', json.encode(patientInfo));
  }

  void _showUpdateDialog(BuildContext context) {
    String gender = patientInfo['Gender'] ?? 'N/A';
    String allergies = patientInfo['Allergies'] ?? 'N/A';
    String hasDiabetes = patientInfo['Has Diabetes'] ?? 'N/A';
    String hasHeartProblems = patientInfo['Has Heart Problems'] ?? 'N/A';
    String height = patientInfo['Height'].toString();
    String weight = patientInfo['Weight'].toString();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 800),
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Update Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  // Gender
                  const Text('Gender', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: patientInfo['Gender'],
                        onChanged: (value) {
                          setState(() {
                            patientInfo['Gender'] = value!;
                          });
                        },
                      ),
                      const Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        groupValue: patientInfo['Gender'],
                        onChanged: (value) {
                          setState(() {
                            patientInfo['Gender'] = value!;
                          });
                        },
                      ),
                      const Text('Female'),
                      Radio<String>(
                        value: 'Other',
                        groupValue: patientInfo['Gender'],
                        onChanged: (value) {
                          setState(() {
                            patientInfo['Gender'] = value!;
                          });
                        },
                      ),
                      const Text('Other'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Allergies
                  const Text('Allergies', style: TextStyle(fontSize: 16)),
                  TextField(
                    controller: TextEditingController(text: allergies),
                    onChanged: (value) {
                      setState(() {
                        patientInfo['Allergies'] = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'N/A (e.g., Peanuts)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Height
                  const Text('Height (cm)', style: TextStyle(fontSize: 16)),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: height),
                    onChanged: (value) {
                      setState(() {
                        patientInfo['Height'] = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'N/A',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Weight
                  const Text('Weight (kg)', style: TextStyle(fontSize: 16)),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: weight),
                    onChanged: (value) {
                      setState(() {
                        patientInfo['Weight'] = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'N/A',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Diabetes
                  const Text('Diabetes', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: patientInfo['Has Diabetes'],
                        onChanged: (value) {
                          setState(() {
                            patientInfo['Has Diabetes'] = value!;
                          });
                        },
                      ),
                      const Text('Yes'),
                      Radio<String>(
                        value: 'No',
                        groupValue: patientInfo['Has Diabetes'],
                        onChanged: (value) {
                          setState(() {
                            patientInfo['Has Diabetes'] = value!;
                          });
                        },
                      ),
                      const Text('No'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Heart Problems
                  const Text('Heart Problems', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Yes',
                        groupValue: patientInfo['Has Heart Problems'],
                        onChanged: (value) {
                          setState(() {
                            patientInfo['Has Heart Problems'] = value!;
                          });
                        },
                      ),
                      const Text('Yes'),
                      Radio<String>(
                        value: 'No',
                        groupValue: patientInfo['Has Heart Problems'],
                        onChanged: (value) {
                          setState(() {
                            patientInfo['Has Heart Problems'] = value!;
                          });
                        },
                      ),
                      const Text('No'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Save and Cancel buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _savePatientInfo();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/userImage.png'),
              ),
            ),
            // Single Card with all personal information and editable details
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Email
                    ListTile(
                      title: Text('${widget.firstName} ${widget.lastName}'),
                      subtitle: Text(widget.email),
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('Gender'),
                      subtitle: Text(patientInfo['Gender'] ?? 'N/A'),
                    ),
                    ListTile(
                      title: const Text('Height'),
                      subtitle: Text('${patientInfo['Height'] ?? 'N/A'} cm'),
                    ),
                    ListTile(
                      title: const Text('Weight'),
                      subtitle: Text('${patientInfo['Weight'] ?? 'N/A'} kg'),
                    ),
                    ListTile(
                      title: const Text('Allergies'),
                      subtitle: Text(patientInfo['Allergies'] ?? 'N/A'),
                    ),
                    ListTile(
                      title: const Text('Has Diabetes'),
                      subtitle: Text(patientInfo['Has Diabetes'] ?? 'N/A'),
                    ),
                    ListTile(
                      title: const Text('Has Heart Problems'),
                      subtitle:
                          Text(patientInfo['Has Heart Problems'] ?? 'N/A'),
                    ),
                    // Edit button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 115, 160, 223), // Button color
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 25.0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30.0), // Rounded shape
                            ),
                            elevation: 5, // Add elevation for raised look
                            shadowColor:
                                Colors.black.withOpacity(0.25), // Shadow color
                          ),
                          onPressed: () {
                            _showUpdateDialog(context);
                          },
                          child: const Text(
                            'Update your Informations',
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Font size
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Logout button outside of the card
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200, // Set the button width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 115, 160, 223), // Button color
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 25.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded shape
                      ),
                      elevation: 5, // Add elevation for raised look
                      shadowColor:
                          Colors.black.withOpacity(0.25), // Shadow color
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16.0, // Font size
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
