import 'package:DocEase/utils/themes/color_themes.dart';
import 'package:DocEase/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customTextWidget(
          text: "Settings",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop the current screen to go back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Profile settings section
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              leading: Icon(Icons.person, color: primaryColor),
              title: customTextWidget(
                text: "Profile",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to the profile screen if needed
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            Divider(color: Colors.grey[400], thickness: 1),

            // Notification settings section
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              leading: Icon(Icons.notifications, color: primaryColor),
              title: customTextWidget(
                text: "Notifications",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to notification settings if needed
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSettingsScreen()));
              },
            ),
            Divider(color: Colors.grey[400], thickness: 1),

            // Theme settings section
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              leading: Icon(Icons.color_lens, color: primaryColor),
              title: customTextWidget(
                text: "Theme",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to theme settings if needed
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ThemeSettingsScreen()));
              },
            ),
            Divider(color: Colors.grey[400], thickness: 1),

            // Language settings section
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              leading: Icon(Icons.language, color: primaryColor),
              title: customTextWidget(
                text: "Language",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to language settings if needed
                // Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSettingsScreen()));
              },
            ),
            Divider(color: Colors.grey[400], thickness: 1),

            // Logout option section
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              leading: Icon(Icons.exit_to_app, color: primaryColor),
              title: customTextWidget(
                text: "Log Out",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
              onTap: () {
                // Handle log out functionality here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
