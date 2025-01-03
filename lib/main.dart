import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gsip_updated/screens/login.dart';
import 'package:gsip_updated/firebase_options.dart';
import 'package:gsip_updated/screens/teachersattendance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase initialized successfully");
  } catch (e) {
    print("Failed to initialize Firebase: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const TeachersAttendancePage());
  }
}
