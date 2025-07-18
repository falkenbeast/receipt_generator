import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authenication/register.dart';
import 'package:receipt_generator/layouts/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Receipt Generator',
      home: RegisterPage(),
    );
  }
}
