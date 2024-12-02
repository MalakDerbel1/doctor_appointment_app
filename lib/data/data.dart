import 'package:DocEase/domain/doctor_model.dart';
import 'package:DocEase/utils/constant/image_constant.dart';

List<String> categories = <String>[
  "🔥 All",
  "👨‍⚕️ Generalist",
  "💉 Dermatologie",
  "👶 Pediatrics",
  "🦷 Dentist",
  "👁️ Ophthalmology",
];

List<DoctorModel> doctorList = [
  // Generalist
  DoctorModel(
    doctorName: "Dr. karim Sahnoun",
    speciality: "Generalist",
    clinicName: "Complex médical",
    totalReviews: 36,
    about:
        "Dr Karim Sahnoun est un médecin Generalist dont le cabinet, numéro 34, se trouve au Complexe Médical.",
    rating: 4.9,
    experience: "7+ years",
    patients: 120,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Example longitude
    doctorImage: ImageConstant.doctor2,
  ),
  DoctorModel(
    doctorName: "Dr. Radhia Neifar",
    speciality: "Generalist",
    clinicName: "immeuble syphax médical",
    totalReviews: 150,
    about:
        "Dr. Radhia Neifar exerce en tant que médecin Generalist, avec un cabinet situé a l'immeuble syphax médical a route gremda km 2.",
    rating: 4.8,
    experience: "10+ years",
    patients: 200,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor1, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Amel Jarraya",
    speciality: "Generalist",
    clinicName: "Care Center",
    totalReviews: 245,
    about:
        " Dr Amel Jarraya exerce en tant que médecin Generalist dans un cabinet situé à résidzncz El Habib ,  route de soukra, km 3.",
    rating: 4.7,
    experience: "8+ years",
    patients: 180,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor5, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Semi Elloumi",
    speciality: "Generalist",
    clinicName: "immeuble Ezaphyr",
    totalReviews: 320,
    about:
        "Dr. Semi Elloumi exerce en tant que médecin Generalist dans un cabinet situé à l'immeuble Ezaphyr ,  route de Manzel chaker, km 5.5",
    rating: 4.9,
    experience: "12+ years",
    patients: 300,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor3, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. khalil  Masmoudi",
    speciality: "Generalist",
    clinicName: "immeuble ElNour",
    totalReviews: 320,
    about:
        "Dr. khalil  Masmoudi exerce en tant que médecin Generalist dans un cabinet situé à l'immeuble ElNour,  route de tunis , km 5.5",
    rating: 4.9,
    experience: "12+ years",
    patients: 300,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor9, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Anis  Chaari",
    speciality: "Generalist",
    clinicName: "immeuble Bosten3", // modifier par adresse et ajouter ville
    totalReviews: 320,
    about:
        "Dr. Anis  Chaari exerce en tant que médecin Generalist dans un cabinet situé à l'immeuble Bosten3,  route de Gabes , km 2.5",
    rating: 4.9,
    experience: "12+ years",
    patients: 300,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor10, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Sahir  Sallemi",
    speciality: "Generalist",
    clinicName: "Complexe medicale ", // modifier par adresse et ajouter ville
    totalReviews: 320,
    about:
        "Dr. Sahir Sallemi  exerce en tant que médecin Generalist dans un cabinet situé à Complexe medicale, Sfax",
    rating: 4.9,
    experience: "12+ years",
    patients: 300,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor6, // Update with the actual path or constant
  ),

  // Dermatologie
  DoctorModel(
    doctorName: "Dr. Najeh Affes",
    speciality: "Dermatologie",
    clinicName: "Immeuble Aida",
    totalReviews: 400,
    about:
        "Dr. Sahir Sallemi practices as a dermatologist in a clinic located in the Aïda building, in Sfax .",
    rating: 4.6,
    experience: "9+ years",
    patients: 250,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor8, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Sonda Ghorbel",
    speciality: "Dermatologie",
    clinicName: "Immeuble Madina Center",
    totalReviews: 400,
    about:
        "Dr. Sonda Ghorbel practices as a dermatologist in a clinic n°25 located in the Madina Center building,Bloc C in Sfax .",
    rating: 4.6,
    experience: "9+ years",
    patients: 250,
    isFav: false,
    
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor7, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Fadhel Chaari",
    speciality: "Dermatologie",
    clinicName: "Immeuble Palmarium",
    totalReviews: 400,
    about:
        "Dr. Fadhel Chaari practices as a dermatologist in a clinic n°3 located in Palmarium building,Bloc A in Sfax .",
    rating: 4.6,
    experience: "9+ years",
    patients: 250,
    isFav: false,
 
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor11, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Mourad Ennouri",
    speciality: "Dermatologie",
    clinicName: "Immeuble intileka",
    totalReviews: 400,
    about:
        "Dr. Mourad Ennouri practices as a dermatologist in a clinic located in intileka building in Sfax .",
    rating: 4.6,
    experience: "9+ years",
    patients: 250,
    isFav: false,
    
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor10, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Atef Maalej",
    speciality: "Dermatologie",
    clinicName: "Immeuble elmajd",
    totalReviews: 400,
    about:
        "Dr. Atef Maalej practices as a dermatologist in a clinic n°7 located in elmajd building in Sfax.",
    rating: 4.6,
    experience: "9+ years",
    patients: 250,
    isFav: false,
    
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor11, // Update with the actual path or constant
  ),

  // Pediatrics
  DoctorModel(
    doctorName: "Dr. Mohamed Ali Mekki",
    speciality: "Pediatrics",
    clinicName: "immeuble Fleur de lys",
    totalReviews: 280,
    about:
        "Dr. Mohamed Ali Mekki is a pediatrician with a clinic (B13) located in the Fleur de Lys building on Route Tanyour, km 4.",
    rating: 4.5,
    experience: "7+ years",
    patients: 110,
    isFav: true,
   
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor12, // Update with the actual path or constant
  ),
  DoctorModel(
    doctorName: "Dr. Hichem Fekki",
    speciality: "Pediatrics",
    clinicName: "immeuble Fleur de lys",
    totalReviews: 280,
    about:
        "Dr. Hichem Fekki is a pediatrician with a clinic located in the Rayen building on  AV.du 14 Janvier.",
    rating: 4.5,
    experience: "7+ years",
    patients: 110,
    isFav: true,
    
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor19 // Update with the actual path or constant
  ),
  DoctorModel(
    doctorName: "Dr. Adel Zouari",
    speciality: "Pediatrics",
    clinicName: "complexe ibn ennafis",
    totalReviews: 280,
    about:
        "Dr.  Adel Zouari is a pediatrician with a clinic (B13) located in ibn ennafis building on Route Tunis, km 4.",
    rating: 4.5,
    experience: "7+ years",
    patients: 110,
    isFav: true,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor13, // Update with the actual path or constant
  ),

  // Dentist
  DoctorModel(
    doctorName: "Dr. Rami Boujelben",
    speciality: "Dentist",
    clinicName: "Kassas Marrakech",
    totalReviews: 280,
    about:
        "Dr. Rami Boujelben is a dentist with a clinic  located in Kassas Marrakech on Route Lafran, km 1.",
    rating: 4.8,
    experience: "11+ years",
    patients: 220,
    isFav: true,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor15, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Walid Jallouli",
    speciality: "Dentist",
    clinicName: "Immeuble Salima",
    totalReviews: 280,
    about:
        "Dr. Walid Jallouli is a dentist with a clinic  located in Salima building on  Route El ain , km 4,5.",
    rating: 4.8,
    experience: "11+ years",
    patients: 220,
    isFav: true,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor14, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Hajer Kammoun",
    speciality: "Dentist",
    clinicName: "Immeuble Teniour centre",
    totalReviews: 280,
    about:
        "Dr. Hajer Kammoun is a dentist with a clinic  located in Teniour centre building on Route Tanyour, km 2.",
    rating: 4.8,
    experience: "11+ years",
    patients: 220,
    isFav: true,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor22, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Emna Bradai ",
    speciality: "Dentist",
    clinicName: "Residence Al Narjess",
    totalReviews: 280,
    about:
        "Dr. Emna Bradai is a dentist with a clinic located in the Al Narjess Residence on Route Lafran, km 5.5.",
    rating: 4.8,
    experience: "11+ years",
    patients: 220,
    isFav: true,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor23, // Update with the actual path or constant
  ),

  // Ophthalmology
  DoctorModel(
    doctorName: "Dr.Maissa Sakka Derbel",
    speciality: "Ophthalmology",
    clinicName: "Immeuble City Center ",
    totalReviews: 350,
    about:
        "Dr. Maissa Sakka Derbel is an ophthalmologist with a clinic located in the City Center building, Rue Majida Boulila, Sfax.",
    rating: 4.7,
    experience: "6+ years",
    patients: 150,
    isFav: false,
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor21, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Mourad Zahaf",
    speciality: "Ophthalmology",
    clinicName: "Immeuble ibn rochd",
    totalReviews: 350,
    about:
        "Dr. Hajer Kammoun is an ophthalmologist with a clinic located in the ibn rochd building  Bloc A ,sfax.",
    rating: 4.7,
    experience: "6+ years",
    patients: 150,
    isFav: false,
   
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor17, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Mohamed Mlik",
    speciality: "Ophthalmology",
    clinicName: "Immeuble Echifa",
    totalReviews: 350,
    about:
        "Dr. Hajer Kammoun is an ophthalmologist with a clinic located in the Echifa building, Sfax.",
    rating: 4.7,
    experience: "6+ years",
    patients: 150,
    isFav: false,
    
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor18, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Wassim Mhiri ",
    speciality: "Ophthalmology",
    clinicName: "Immeuble Ihsen",
    totalReviews: 350,
    about:
        "Dr. Hajer Kammoun is an ophthalmologist with a clinic located in the Ihsen building ,Sfax.",
    rating: 4.7,
    experience: "6+ years",
    patients: 150,
    isFav: false,
    
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor43, // Update with the actual path or constant
  ),

  DoctorModel(
    doctorName: "Dr. Amine Ennouri",
    speciality: "Ophthalmology",
    clinicName: "Complexe Medical city",
    totalReviews: 350,
    about:
        "Dr. Hajer Kammoun is an ophthalmologist with a clinic located in Complexe Medical city on Route Ain, km 0.5.",
    rating: 4.7,
    experience: "6+ years",
    patients: 150,
    isFav: false,
    
    latitude: 34.8151642, // Example latitude
    longitude: 10.7357895, // Update with the actual path or constant
    doctorImage:
        ImageConstant.doctor16, // Update with the actual path or constant
  ),
];

List<DoctorModel> favoriteDoctors =
    doctorList.where((doctor) => doctor.isFav).toList();
