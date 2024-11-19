class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profileImage;

  // Constructor
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profileImage = 'assets/userImage.png', // Default profile image
  });

  // Method to get full name
  String getFullName() {
    return '$firstName $lastName';
  }

  // Method to print user details
  @override
  String toString() {
    return 'User: { Full Name: ${getFullName()}, Email: $email, Phone: $phoneNumber }';
  }
}
