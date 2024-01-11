import 'package:flutter/material.dart';
import 'package:ios_fitness/screens/user.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
              backgroundColor: const Color(0xFF0A0E20),
            ),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: const User(),
    );
  }
}
// const Color(0xFF0A0E20),
//
// const Color(0xFF0A0E21),
