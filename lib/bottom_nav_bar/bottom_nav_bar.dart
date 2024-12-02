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
    // Initialisez les pages avec les données passées
    _pages = [
      HomeScreen(
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
      ),
      ChatScreen(),
      ProfileScreen(
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
        patientInfo: {}, // Fournissez un dictionnaire si nécessaire
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
            // En-tête du drawer
            UserAccountsDrawerHeader(
              accountName: Text("${widget.firstName} ${widget.lastName}"),
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
            // Éléments du drawer
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
              leading: const Icon(Icons.message),
              title: const Text('Chat'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  _selectedIndex = 2; // Correspond à l'indice de ProfileScreen
                });
                Navigator.pop(context);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnboardingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // Affiche l'écran correspondant
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
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
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
