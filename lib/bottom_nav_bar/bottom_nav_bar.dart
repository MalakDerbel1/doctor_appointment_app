import 'package:doctor_appointment_app/screens/calendar_screen/calendar_screen.dart';
import 'package:doctor_appointment_app/screens/chat_screen/chat_screen.dart';
import 'package:doctor_appointment_app/screens/home_screen/home_screen.dart';
import 'package:doctor_appointment_app/screens/profile/profile_screen.dart';
import 'package:doctor_appointment_app/utils/themes/color_themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class BottomNavBar extends StatefulWidget {
  final String firstName;
  final String lastName;

  const BottomNavBar({
    Key? key,
    required this.firstName,
    required this.lastName,
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
    // Initialize the pages with the passed data
    _pages = [
      HomeScreen(
        firstName: widget.firstName,
        lastName: widget.lastName,
      ),
      ClientAppointmentCalendar(),
      ChatScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 80,
            color: Colors.white,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavBarItem(FontAwesomeIcons.house, 0),
                  _buildNavBarItem(FontAwesomeIcons.calendar, 1),
                  _buildNavBarItem(FontAwesomeIcons.message, 2),
                  _buildNavBarItem(Icons.person, 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Icon(
        icon,
        size: 24,
        color: _selectedIndex == index ? primaryColor : lighterColor,
      ),
    );
  }
}
