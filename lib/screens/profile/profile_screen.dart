import 'package:DocEase/screens/auth_screens/login_screen/login_screen.dart';
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
            Divider(),
            Text(email, style: TextStyle(fontSize: 18)),
            Divider(),
            // Display other patient information
            Text('Gender: ${patientInfo['Gender']}'),
            Divider(),
            Text('Height: ${patientInfo['Height']} cm'),
            Divider(),
            Text('Weight: ${patientInfo['Weight']} kg'),
            Divider(),
            Text('Allergies: ${patientInfo['Allergies']}'),
            Divider(),
            Text('Medical History: ${patientInfo['Medical History']}'),
            Divider(),
            Text('Lifestyle: ${patientInfo['Lifestyle']}'),
            Divider(),
            Text('Date of Visit: ${patientInfo['Date of Visit']}'),
            Divider(),
            // Display new health conditions
            Text('Has Diabetes: ${patientInfo['Has Diabetes']}'),
            Divider(),
            Text('Has Heart Problems: ${patientInfo['Has Heart Problems']}'),
            Divider(),
            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the login screen (OnboardingScreen)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(), // Assuming this is your login screen
                    ),
                  );
                },
                child: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 40.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
