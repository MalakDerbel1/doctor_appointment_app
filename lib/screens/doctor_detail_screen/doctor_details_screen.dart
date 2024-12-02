import 'package:DocEase/domain/doctor_model.dart';
import 'package:DocEase/screens/calendar_screen/calendar_screen.dart';
import 'package:DocEase/screens/call_screen/call_screen.dart';
import 'package:DocEase/screens/doctor_detail_screen/icon_widget.dart';
import 'package:DocEase/utils/constant/app_constant.dart';
import 'package:DocEase/utils/constant/image_constant.dart';
import 'package:DocEase/utils/themes/color_themes.dart';
import 'package:DocEase/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final DoctorModel doctorModel;
  const DoctorDetailsScreen({super.key, required this.doctorModel});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  String? _reservedDate;
  String? _reservedTime;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  void _showReservationDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Réservation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(labelText: 'Date'),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(labelText: 'Hour'),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                final date = _dateController.text;
                final time = _timeController.text;

                if (date.isEmpty || time.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select both a date and a time."),
                    ),
                  );
                  return; // Exit the method if fields are empty
                }

                setState(() {
                  _reservedDate = date;
                  _reservedTime = time;
                });

                // Save reservation data with the doctor's ID
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString(
                    '${widget.doctorModel.doctorName}_reservedDate', date);
                await prefs.setString(
                    '${widget.doctorModel.doctorName}_reservedTime', time);

                Navigator.of(context).pop();

                // Navigate to ClientAppointmentCalendar with reservation details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientAppointmentCalendar(
                      selectedDate: date,
                      selectedTime: time,
                      doctorName: widget.doctorModel.doctorName,
                    ),
                  ),
                );
              },
              child: const Text('Book'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadReservation();
  }

  void _loadReservation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _reservedDate =
          prefs.getString('${widget.doctorModel.doctorName}_reservedDate');
      _reservedTime =
          prefs.getString('${widget.doctorModel.doctorName}_reservedTime');
    });
  }

  void _callVoice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(
          doctorModel: widget.doctorModel,
        ),
      ),
    );
  }

  void _openGoogleMaps() async {
    if (widget.doctorModel.latitude != null &&
        widget.doctorModel.longitude != null) {
      final lat = widget.doctorModel.latitude!;
      final lng = widget.doctorModel.longitude!;

      final Uri googleMapsUri = Uri.parse(
          'https://maps.google.com/?q=$lat,$lng'); // Use the https URL

      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open Google Maps.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location not available for this doctor.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Back Button and Title
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Spacer(),
                    customTextWidget(
                      text: "Doctor Details",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),

                // Doctor's Profile Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor Image
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.doctorModel.doctorImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customTextWidget(
                              text: widget.doctorModel.doctorName,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 5),
                            customTextWidget(
                              text:
                                  "${widget.doctorModel.speciality} | ${widget.doctorModel.clinicName}",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: lighterColor,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Color(0xffFFD33C)),
                                customTextWidget(
                                  text: widget.doctorModel.rating.toString(),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                customTextWidget(
                                  text:
                                      " (${widget.doctorModel.totalReviews} reviews)",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: lighterColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Localisation Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _openGoogleMaps,
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text('See Localisation'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 133, 198, 170),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Doctor Statistics Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customIconWidget(
                      imageIcon: ImageConstant.patientIcon,
                      fieldValue: "${widget.doctorModel.patients}+",
                      headingValue: "Patients",
                    ),
                    customIconWidget(
                      imageIcon: ImageConstant.experienceIcon,
                      fieldValue: "${widget.doctorModel.experience}+",
                      headingValue: "Years Exp",
                    ),
                    customIconWidget(
                      imageIcon: ImageConstant.ratingIcon,
                      fieldValue: widget.doctorModel.rating.toString(),
                      headingValue: "Rating",
                    ),
                    customIconWidget(
                      imageIcon: ImageConstant.reviewsIcon,
                      fieldValue: "${widget.doctorModel.totalReviews}+",
                      headingValue: "Reviews",
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // About Me Section
                customTextWidget(
                  text: "About Me",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                customTextWidget(
                  text: widget.doctorModel.about,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: lighterColor,
                  lineHeight: 1.5,
                ),
                if (_reservedDate != null && _reservedTime != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextWidget(
                            text: "Your Reservation:",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 15),
                          customTextWidget(
                            text: "Doctor: ${widget.doctorModel.doctorName}",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 10),
                          customTextWidget(
                            text: "Date: $_reservedDate",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 10),
                          customTextWidget(
                            text: "Time: $_reservedTime",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ),
                  ),

                // Call and Book Buttons
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _callVoice,
                      icon: const Icon(Icons.call, color: Colors.white),
                      label: const Text('Call Voice'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.25),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _showReservationDialog,
                      icon: Icon(Icons.calendar_today, color: blackishColor),
                      label: const Text('Book'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: blackishColor,
                        backgroundColor: lightPurpleColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
