import 'package:DocEase/domain/doctor_model.dart';
import 'package:DocEase/screens/calendar_screen/calendar_screen.dart';
import 'package:DocEase/screens/call_screen/call_screen.dart';
import 'package:DocEase/screens/doctor_detail_screen/icon_widget.dart';
import 'package:DocEase/utils/constant/app_constant.dart';
import 'package:DocEase/utils/constant/image_constant.dart';
import 'package:DocEase/utils/themes/color_themes.dart';
import 'package:DocEase/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now(); // Date actuelle

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${selectedDate.toLocal()}".split(
            ' ')[0]; // Mettre à jour le champ de texte avec la date choisie
      });
    }
  }

  void _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now(); // Heure actuelle

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = selectedTime.format(
            context); // Mettre à jour le champ de texte avec l'heure choisie
      });
    }
  }

  // Function to show reservation dialog
 void _showReservationDialog() async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Réservation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Champ Date
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
            // Champ Heure
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
            onPressed: () {
              // Récupérer les informations de réservation
              final date = _dateController.text;
              final time = _timeController.text;

              setState(() {
                _reservedDate = date;
                _reservedTime = time;
              });

              Navigator.of(context).pop(); // Fermer la boîte de dialogue

              // Passer les informations à ClientAppointmentCalendar
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            mediumSpaceh,
            Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  customTextWidget(
                      text: "My Appointments",
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  const Spacer(),
                ])),
            Container(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width *
                    0.9, // Add horizontal padding for spacing
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.doctorModel.doctorImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 20),
                              child: customTextWidget(
                                text: widget.doctorModel.doctorName,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 5),
                              child: customTextWidget(
                                text:
                                    "${widget.doctorModel.speciality} | ${widget.doctorModel.clinicName}",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: lighterColor,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_purple500_outlined,
                                color: Color(0xffFFD33C),
                                size: 16,
                              ),
                              customTextWidget(
                                text: widget.doctorModel.rating.toString(),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              customTextWidget(
                                text:
                                    "(${widget.doctorModel.totalReviews.toString()} reviews)",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: lighterColor,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  // color: lighterColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                          ),
                          child: customIconWidget(
                            imageIcon: ImageConstant.patientIcon,
                            fieldValue:
                                "${widget.doctorModel.patients.toString()}+",
                            headingValue: "Patients",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                          ),
                          child: customIconWidget(
                            imageIcon: ImageConstant.experienceIcon,
                            fieldValue:
                                "${widget.doctorModel.experience.toString()}+",
                            headingValue: "Years Exp",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                          ),
                          child: customIconWidget(
                            imageIcon: ImageConstant.ratingIcon,
                            fieldValue:
                                "${widget.doctorModel.rating.toString()}",
                            headingValue: "Rating",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                          ),
                          child: customIconWidget(
                            imageIcon: ImageConstant.reviewsIcon,
                            fieldValue:
                                "${widget.doctorModel.totalReviews.toString()}+",
                            headingValue: "Reviews",
                          ),
                        ),
                      ],
                    ),
                    mediumSpaceh,
                    customTextWidget(
                        text: "About Me",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    mediumSpaceh,
                    customTextWidget(
                        text: widget.doctorModel.about,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: lighterColor,
                        lineHeight: 1.5),
                  ],
                ),
              ),
            ),









            
            Padding(
              
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _callVoice,
                    icon: const Icon(Icons.call,
                        color:
                            Colors.white), // Icône pour le bouton "Call Voice"
                    label: const Text('Call Voice'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor, // Couleur du texte
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        // Coins arrondis
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5, // Ombre portée pour donner du relief
                      shadowColor:
                          Colors.black.withOpacity(0.25), // Ombre légère
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showReservationDialog,
                    icon: Icon(Icons.calendar_today,
                        color: blackishColor), // Icône pour le bouton "Reserve"
                    label: const Text('Reserve'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: blackishColor,
                      backgroundColor: lightPurpleColor, // Couleur du texte
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        // Coins arrondis
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5, // Ombre portée pour donner du relief
                      shadowColor:
                          Colors.black.withOpacity(0.25), // Ombre légère
                    ),
                  ),
                  if (_reservedDate != null && _reservedTime != null)
  Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTextWidget(
            text: "Your Reservation:",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          customTextWidget(
            text: "Doctor: ${widget.doctorModel.doctorName}",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          customTextWidget(
            text: "Date: $_reservedDate",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          customTextWidget(
            text: "Time: $_reservedTime",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ],
      ),
    ),
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