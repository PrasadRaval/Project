
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.cyan
      ),
      home: const SplashScreen(),
    );
  }
}