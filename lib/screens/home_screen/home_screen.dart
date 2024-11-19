import 'package:flutter/material.dart';
import 'package:DocEase/data/data.dart'; // Your sample data file
import 'package:DocEase/domain/doctor_model.dart'; // Your doctor model
import 'package:DocEase/screens/doctor_detail_screen/doctor_details_screen.dart'; // Doctor details screen
import 'package:DocEase/utils/constant/app_constant.dart'; // Constants file
import 'package:DocEase/utils/constant/image_constant.dart'; // Image constants
import 'package:DocEase/utils/themes/color_themes.dart'; // Color theme file
import 'package:DocEase/utils/widgets/text_widget.dart'; // Custom text widget
import 'package:DocEase/utils/widgets/transparent_text_field_widget.dart'; // Transparent search field widget
import 'package:lottie/lottie.dart'; // For animations like search animation

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
  // Define a filtered list of doctors based on search
  List<DoctorModel> filteredDoctors = [];
  String selectedSpeciality = "All"; // Default speciality
  List<String> specialities = [
    "Generalist",
    "Dermatologie",
    "Pediatrics",
    "Dentist",
    "Ophthalmology"
  ];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctorList; // Initial list shows all doctors
  }

  TextEditingController searchController = TextEditingController();
  String searchQuery = ''; // Track the search field value

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

  // Function to filter doctors based on selected speciality
  void filterDoctorsBySpeciality(String speciality) {
    setState(() {
      selectedSpeciality = speciality;

      if (speciality == "All") {
        // Show all doctors without filtering by speciality
        filteredDoctors = doctorList;
      } else {
        // Show doctors matching the selected speciality
        filteredDoctors = doctorList.where((doctor) {
          return doctor.speciality.toLowerCase() == speciality.toLowerCase();
        }).toList();
      }
    });
  }

  // Build the filtered doctor list vertically
  Widget buildFilteredDoctorList() {
    return ListView.builder(
      shrinkWrap: true,
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
                  SizedBox(width: 16),
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
    // Filter the doctors based on the search query
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Bar with user info and actions like notifications and tips
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
                    mediumSpaceh,
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/userImage.png"),
                        ),
                        smallSpacew,
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
                        // Notifications and Tips icon buttons

                        IconButton(
                          onPressed: _showNotifications,
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        // Icône pour les astuces
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
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Specialities filter buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => filterDoctorsBySpeciality('All'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: selectedSpeciality == 'All'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSpeciality == 'All'
                          ? Colors.blue
                          : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                  // Specialty buttons
                  ...specialities.map((speciality) {
                    return ElevatedButton(
                      onPressed: () => filterDoctorsBySpeciality(speciality),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          speciality,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: selectedSpeciality == speciality
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedSpeciality == speciality
                            ? Colors.blue
                            : Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            // Show filtered doctor list or "No results" message
            filteredDoctors.isNotEmpty
                ? buildFilteredDoctorList()
                : Padding(
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
                        mediumSpaceh,
                        Lottie.asset(
                          'assets/searchJson.json',
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
