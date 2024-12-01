import 'package:flutter/material.dart';
import 'package:DocEase/data/data.dart'; // Sample data file
import 'package:DocEase/domain/doctor_model.dart'; // Doctor model
import 'package:DocEase/screens/doctor_detail_screen/doctor_details_screen.dart'; // Doctor details screen
import 'package:DocEase/utils/constant/app_constant.dart'; // Constants file
import 'package:DocEase/utils/constant/image_constant.dart'; // Image constants
import 'package:DocEase/utils/themes/color_themes.dart'; // Color themes
import 'package:DocEase/utils/widgets/text_widget.dart'; // Custom text widget
import 'package:DocEase/utils/widgets/transparent_text_field_widget.dart'; // Transparent search field widget
import 'package:lottie/lottie.dart'; // For animations like search animations

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String email;
  final String firstName;
  final String lastName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DoctorModel> filteredDoctors = [];
  String selectedSpeciality = "All"; // Default speciality
  List<String> specialities = [
    "Generalist",
    "Dermatologie",
    "Pediatrics",
    "Dentist",
    "Ophthalmology",
  ];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctorList; // Show all doctors initially
  }

  TextEditingController searchController = TextEditingController();
  String searchQuery = ''; // Track the search field value

  // Function to filter doctors by search query and speciality
  void filterDoctors() {
    setState(() {
      filteredDoctors = doctorList.where((doctor) {
        final nameLower = doctor.doctorName.toLowerCase();
        final specialityLower = doctor.speciality.toLowerCase();
        final searchLower = searchQuery.toLowerCase();

        bool matchesSpeciality = selectedSpeciality == 'All' ||
            specialityLower == selectedSpeciality.toLowerCase();
        bool matchesSearch = nameLower.contains(searchLower) ||
            specialityLower.contains(searchLower);

        return matchesSearch && matchesSpeciality;
      }).toList();
    });
  }

  // Function to update the speciality filter
  void filterDoctorsBySpeciality(String speciality) {
    setState(() {
      selectedSpeciality = speciality;
      filterDoctors(); // Update filtered list based on the speciality
    });
  }

  // Sample notifications data
  final List<String> notifications = [
    "New appointment booked for tomorrow.",
    "You have a new message from Dr. Smith.",
    "Your appointment with Dr. Johnson is confirmed.",
    "Your prescription is ready for pickup.",
    "A new health tip is available for you."
  ];
  // Sample tips data
  final List<String> tips = [
    "Drink at least 8 glasses of water a day.",
    "Exercise regularly to stay fit.",
    "Take breaks and avoid sitting for long periods.",
    "Get enough sleep to recharge your body.",
    "Eat a balanced diet with plenty of fruits and vegetables."
  ];

  // Function to show tips list
  void _showTips() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Health Tips"),
          content: Container(
            height: 200,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: tips.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tips[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notifications"),
          content: Container(
            height: 200,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notifications[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // Build speciality filter buttons with horizontal scrolling
  Widget buildSpecialityButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...["All", ...specialities].map((speciality) {
            final bool isSelected = selectedSpeciality == speciality;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () => filterDoctorsBySpeciality(speciality),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                ),
                child: Text(
                  speciality,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Build filtered doctor list vertically
  Widget buildFilteredDoctorList() {
    if (filteredDoctors.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextWidget(
              text: "No doctor found.",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Lottie.asset(
              'assets/searchJson.json', // Assurez-vous que ce fichier existe
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = filteredDoctors[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DoctorDetailsScreen(doctorModel: doctor),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      doctor.doctorImage,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTextWidget(
                        text: doctor.doctorName,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      customTextWidget(
                        text: doctor.speciality,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Bar with user info and actions
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                image: const DecorationImage(
                  image: AssetImage(ImageConstant.homeTexture),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/userImage.png"),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customTextWidget(
                              text: "Hello, Welcome 🎉",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            customTextWidget(
                              text: "${widget.lastName} ${widget.firstName}",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _showNotifications,
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: _showTips,
                          icon: const Icon(
                            Icons.lightbulb_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    TransparentSearchField(
                      controller: searchController,
                      onSearch: (value) {
                        setState(() {
                          searchQuery = value;
                          filterDoctors();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildSpecialityButtons(),
            const SizedBox(height: 20),
            buildFilteredDoctorList(),
          ],
        ),
      ),
    );
  }
}
