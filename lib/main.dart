import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/doctor_profile.dart';
import 'package:test/providers/patient_profile.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/screens/addUserDetail.dart';
import 'package:test/screens/passwordReset.dart';
import 'package:test/screens/scheduledAppointment.dart';
import 'package:test/screens/MessageListScreen.dart';
import 'package:test/screens/appointment.dart';
import 'package:test/screens/bookAppointment.dart';
import 'package:test/screens/resultScreen.dart';
import 'package:test/screens/setting.dart';
import 'package:test/services/auth_services.dart';
import './screens/tabScreen.dart';
import './screens/homeScreen.dart';
import './screens/profile.dart';
import 'helper/users.dart';
import './screens/diagnosis.dart';
import './screens/aboutUs.dart';
import './screens/nearbyDoctors.dart';
import './screens/reportScreen.dart';
import 'screens/uploadScreen.dart';
import 'helper/diseaseLabels.dart';
import 'helper/reports.dart';
import './screens/editProfile.dart';
import './screens/symptomsScreen.dart';
import './screens/splashScreen.dart';
import './screens/doctorDetail.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => DoctorProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => PatientProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor createMaterialColor(Color color) {
      List strengths = <double>[.05];
      Map<int, Color> swatch = {};
      final int r = color.red, g = color.green, b = color.blue;

      for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
      for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
      return MaterialColor(color.value, swatch);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Users>(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider<DiseaseLabels>(
          create: (ctx) => DiseaseLabels(),
        ),
        ChangeNotifierProvider<Reports>(
          create: (ctx) => Reports(),
        ),
        ChangeNotifierProvider(
          create: (_) => DoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PatientProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Point Of Care',
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFF7F80D2)),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Provider.of<UserProvider>(context).user.token.isEmpty
            ? const SplashScreen()
            : const TabsScreen(),
        routes: {
          TabsScreen.routeName: (ctx) => const TabsScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          SettingScreen.routeName: (ctx) => const SettingScreen(),
          Profile.routeName: (ctx) => Profile(),
          Diagnosis.routeName: (ctx) => const Diagnosis(),
          AboutUs.routeName: (ctx) => const AboutUs(),
          NearbyDoctors.routeName: (ctx) => const NearbyDoctors(),
          UploadScreen.routeName: (ctx) => const UploadScreen(),
          ResultScreen.routeName: (ctx) => const ResultScreen(),
          ReportScreen.routeName: (ctx) => ReportScreen(),
          EditProfile.routeName: (ctx) => EditProfile(),
          AppointmentScreen.routeName: (ctx) => const AppointmentScreen(),
          SymptomsScreen.routeName: (ctx) => const SymptomsScreen(),
          DoctorDetail.routeName: (ctx) => const DoctorDetail(),
          BookAppointment.routeName: (ctx) => const BookAppointment(),
          MessagesScreen.routeName: (ctx) => const MessagesScreen(),
          ScheduleScreen.routeName: (ctx) => const ScheduleScreen(),
          AddUserDetail.routeName: (ctx) => const AddUserDetail(),
          PasswordReset.routeName: (ctx) => const PasswordReset(),
        },
      ),
    );
  }
}
