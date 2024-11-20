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
            color: Colors.white),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // This will pop the current screen off the navigation stack and return to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Profile settings section
            ListTile(
              leading: Icon(Icons.person, color: primaryColor),
              title: customTextWidget(
                text: "Profile",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to the profile screen if needed
              },
            ),
            Divider(color: Colors.grey),

            // Notification settings section
            ListTile(
              leading: Icon(Icons.notifications, color: primaryColor),
              title: customTextWidget(
                text: "Notifications",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to notification settings if needed
              },
            ),
            Divider(color: Colors.grey),

            // Theme settings section
            ListTile(
              leading: Icon(Icons.color_lens, color: primaryColor),
              title: customTextWidget(
                text: "Theme",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to theme settings if needed
              },
            ),
            Divider(color: Colors.grey),

            // Language settings section
            ListTile(
              leading: Icon(Icons.language, color: primaryColor),
              title: customTextWidget(
                text: "Language",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                // Navigate to language settings if needed
              },
            ),
            Divider(color: Colors.grey),

            // Logout option section
            ListTile(
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
