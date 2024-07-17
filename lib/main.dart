import 'package:chartify/pages/login_page.dart';
import 'package:chartify/pages/registration_page.dart';
import 'package:chartify/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
      },
      // home: const LoginPage(),
      // home: const RegistrationPage(),
    );
  }
}
