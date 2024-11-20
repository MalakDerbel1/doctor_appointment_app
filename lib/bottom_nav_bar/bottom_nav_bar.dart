import 'package:DocEase/screens/Mes_informations/mes_informations.dart';
import 'package:DocEase/screens/calendar_screen/calendar_screen.dart';
import 'package:DocEase/screens/chat_screen/chat_screen.dart';
import 'package:DocEase/screens/home_screen/home_screen.dart';
import 'package:DocEase/screens/onboarding_screen/onboarding_screen.dart';
import 'package:DocEase/screens/profile/profile_screen.dart';
import 'package:DocEase/screens/settings/settings_screen.dart';
import 'package:DocEase/utils/themes/color_themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String? appointmentDate; // Nullable appointment date
  final String? appointmentTime; // Nullable appointment time

  const BottomNavBar({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.appointmentDate,
    this.appointmentTime,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages with passed data
    _pages = [
      HomeScreen(
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
      ),
      ClientAppointmentCalendar(),
      ChatScreen(),
      ProfileScreen(
        firstName: widget.firstName, // Pass firstName
        lastName: widget.lastName, // Pass lastName
        email: widget.email, // Pass email
        patientInfo: {
          'Gender':
              'Male', // Example gender, you should get this from the form or database
          'Height': '175', // Example height
          'Weight': '70', // Example weight
          'Allergies': 'Peanuts', // Example allergy
          'Medical History': 'None', // Example medical history
          'Lifestyle': 'Active', // Example lifestyle
          'Date of Visit':
              widget.appointmentDate ?? 'Not provided', // Example date
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DocEase"),
        backgroundColor: primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            UserAccountsDrawerHeader(
              accountName: Text(widget.firstName + " " + widget.lastName),
              accountEmail: Text(widget.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 40,
                ),
              ),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
            ),
            // Drawer Items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Appointments'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Chat'),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  _selectedIndex = 3; // Change the selected index for profile
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Mes informations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientInformationForm(
                      firstName: widget.firstName, // Pass firstName
                      lastName: widget.lastName, // Pass lastName
                      email: widget.email,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Navigate to Login Screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingScreen(),
                    ));
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendar),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: lighterColor,
        type: BottomNavigationBarType.fixed, // Keeps all items visible
      ),
    );
  }
}
