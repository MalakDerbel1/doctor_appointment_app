class DoctorModel {
  final String doctorName;
  final String speciality;
  final String clinicName;
  final int totalReviews;
  final String about;
  final double rating;
  final String experience;
  final int patients;
  late bool isFav; // `late` pour initialisation différée
  final String doctorImage;

  DoctorModel({
    required this.doctorName,
    required this.speciality,
    required this.clinicName,
    required this.totalReviews,
    required this.about,
    required this.rating,
    required this.experience,
    required this.patients,
    required this.isFav,
    required this.doctorImage,
  });

  // Factory method to create a DoctorModel from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorName: json['doctorName'] as String,
      speciality: json['speciality'] as String,
      clinicName: json['clinicName'] as String,
      totalReviews: json['totalReviews'] as int,
      about: json['about'] as String,
      rating: (json['rating'] as num).toDouble(),
      experience: json['experience'] as String,
      patients: json['patients'] as int,
      isFav: json['isFav'] as bool,
      doctorImage: json['doctorImage'] as String,
    );
  }

  // Method to convert DoctorModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'speciality': speciality,
      'clinicName': clinicName,
      'totalReviews': totalReviews,
      'about': about,
      'rating': rating,
      'experience': experience,
      'patients': patients,
      'isFav': isFav,
      'doctorImage': doctorImage,
    };
  }
}
