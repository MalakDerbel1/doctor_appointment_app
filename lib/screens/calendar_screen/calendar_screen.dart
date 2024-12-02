import 'package:flutter/material.dart';

class ClientAppointmentCalendar extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final String doctorName;

  const ClientAppointmentCalendar({
    required this.selectedDate,
    required this.selectedTime,
    required this.doctorName,
    Key? key,
  }) : super(key: key);

  @override
  _ClientAppointmentCalendarState createState() =>
      _ClientAppointmentCalendarState();
}

class _ClientAppointmentCalendarState extends State<ClientAppointmentCalendar> {
  String? _selectedPaymentMethod;
  final _creditCardFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isPaymentValid = false; // Track if the payment is valid

  // Function to show the payment method dialog
  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Payment Method'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Cash'),
                leading: Radio<String>(
                  value: 'Cash',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                    Navigator.pop(context); // Close dialog
                    _processPayment(context);
                  },
                ),
              ),
              ListTile(
                title: const Text('Credit Card'),
                leading: Radio<String>(
                  value: 'Credit Card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                    Navigator.pop(context); // Close dialog
                    _showCreditCardForm(context); // Show credit card form
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreditCardForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Credit Card Information'),
          content: SingleChildScrollView(
            child: Form(
              key: _creditCardFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Email regex validation
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: const InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                    maxLength: 16, // Limit input to 16 digits
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your card number';
                      }
                      if (value.length != 16 || int.tryParse(value) == null) {
                        return 'Card number must be 16 digits';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _expirationDateController,
                    decoration: const InputDecoration(
                        labelText: 'Expiration Date (MM/YY)'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the expiration date';
                      }
                      // Validate expiration date format
                      final dateRegex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');

                      if (!dateRegex.hasMatch(value)) {
                        return 'Enter a valid expiration date (MM/YY)';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cvvController,
                    decoration:
                        const InputDecoration(labelText: 'Security Code (CVV)'),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 3, // Limit CVV to 3 digits
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter CVV';
                      }
                      if (value.length != 3 || int.tryParse(value) == null) {
                        return 'CVV must be 3 digits';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close form dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_creditCardFormKey.currentState!.validate()) {
                  Navigator.pop(context); // Close form dialog
                  _processPayment(context); // Simulate payment processing
                  setState(() {
                    // Mark payment as valid
                    _isPaymentValid = true;
                  });
                  // Show a success message at the bottom using a SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: const [
                          Icon(Icons.check_circle_outline, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Payment Valid',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // Function to simulate the payment process
  void _processPayment(BuildContext context) {
    if (_selectedPaymentMethod != null) {
      // Payment is processed
      setState(() {
        _isPaymentValid = true; // Payment marked as valid
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color.fromARGB(255, 115, 160, 223);
    Color lightPurpleColor = const Color(0xffC8C8F4);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Appointment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Appointment Details:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Doctor: ${widget.doctorName}"),
            Text("Date: ${widget.selectedDate}"),
            Text("Time: ${widget.selectedTime}"),
            const SizedBox(height: 20),

            // Displaying payment status with an elegant label above the button
            if (_isPaymentValid)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue
                        .withOpacity(0.1), // Background color changed to blue
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.blue), // Border color changed to blue
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.blue, // Icon color changed to blue
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Payment Valid',
                        style: TextStyle(
                          color: Colors.blue, // Text color changed to blue
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Buttons displayed side by side with primaryColor and lightPurpleColor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showPaymentDialog(context); // Show payment method dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        primaryColor, // Primary color for the button
                  ),
                  child: const Text("Pay"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Return to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        lightPurpleColor, // Light purple color for the button
                  ),
                  child: const Text("Back to Doctor Details"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
