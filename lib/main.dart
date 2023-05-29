import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_reader_app/src/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Enable Firebase Authentication persistence
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(const NewsReaderApp());
}

class NewsReaderApp extends StatelessWidget {
  const NewsReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Reader',
      // theme: appTheme,
      home: LoginScreen(),
    );
  }
}