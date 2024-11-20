import 'package:DocEase/screens/onboarding_screen/onboarding_screen.dart';
import 'package:DocEase/utils/constant/image_constant.dart';
import 'package:DocEase/utils/themes/color_themes.dart';
import 'package:DocEase/utils/widgets/button_widget.dart';
import 'package:DocEase/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';

// ProfileScreen.dart
// ProfileScreen.dart

class ProfileScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
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
            // Display the user's name and email
            Text('$firstName $lastName', style: TextStyle(fontSize: 22)),
            Text(email, style: TextStyle(fontSize: 18)),
            Divider(),
            // Display other patient information
            Text('Gender: ${patientInfo['Gender']}'),
            Text('Height: ${patientInfo['Height']} cm'),
            Text('Weight: ${patientInfo['Weight']} kg'),
            Text('Allergies: ${patientInfo['Allergies']}'),
            Text('Medical History: ${patientInfo['Medical History']}'),
            Text('Lifestyle: ${patientInfo['Lifestyle']}'),
            Text('Date of Visit: ${patientInfo['Date of Visit']}'),
          ],
        ),
      ),
    );
  }
}
