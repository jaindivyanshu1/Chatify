import 'package:chartify/pages/home_page.dart';
import 'package:chartify/pages/login_page.dart';
import 'package:chartify/pages/registration_page.dart';
import 'package:chartify/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // DatabaseService.instance.createUserInDb("0123", "user1", "user1@gmail.com", "http://www.pravat.cc");
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: NavigationService.instance.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      initialRoute: "login",
      routes: {
        "login": (BuildContext context) => LoginPage(),
        "register": (BuildContext context) => RegistrationPage(),
        "home": (BuildContext context) => HomePage(),
      },
      // home: const LoginPage(),
      // home: const RegistrationPage(),
    );
  }
}
