
import 'package:doctor_appointment_app/data/data.dart';
import 'package:doctor_appointment_app/domain/doctor_model.dart';
import 'package:doctor_appointment_app/screens/doctor_detail_screen/doctor_details_screen.dart';
import 'package:doctor_appointment_app/utils/constant/app_constant.dart';
import 'package:doctor_appointment_app/utils/constant/image_constant.dart';
import 'package:doctor_appointment_app/utils/themes/color_themes.dart';
import 'package:doctor_appointment_app/utils/widgets/text_widget.dart';
import 'package:doctor_appointment_app/utils/widgets/transparent_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    " Generalist",
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
  // Function to filter doctors based on selected speciality

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
  TextEditingController searchController = TextEditingController();
  // Track the search field value
  String searchQuery = '';

  // Track the selected category index
  int selectedIndex = 0;

  // Build the normal UI when no search is performed

  // Build the filtered doctor list based on the search query
  Widget buildFilteredDoctorList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
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
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 134,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(doctor.doctorImage),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customTextWidget(
                                  text: doctor.doctorName,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                customTextWidget(
                                  text: doctor.speciality,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

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

// Function to show notification list
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
  @override
Widget build(BuildContext context) {
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
          // App Bar avec les informations utilisateur et filtres
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
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
                      // Icône de notification
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
                  // Champ de recherche stylisé
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

          mediumSpaceh,

          // Rangée de filtres par spécialité avec l'ajout de l'option "All"
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

          // Affichage de la liste de médecins sous forme de cartes
          filteredDoctors.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = filteredDoctors[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(doctor.doctorImage),
                        ),
                        title: customTextWidget(
                          text: doctor.doctorName,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: customTextWidget(
                          text: doctor.speciality,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Action lors du clic sur un médecin
                        },
                      ),
                    );
                  },
                )
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

void filterDoctorsBySpeciality(String speciality) {
  setState(() {
    selectedSpeciality = speciality;

    if (speciality == "All") {
      filteredDoctors = doctorList.where((doctor) {
        return doctor.speciality.toLowerCase() == "dentist" ||
            doctor.speciality.toLowerCase() == "ophthalmology";
      }).toList();
    } else {
      filteredDoctors = doctorList.where((doctor) {
        return doctor.speciality.toLowerCase() == speciality.toLowerCase();
      }).toList();
    }
  });
}
}