import 'package:flutter/material.dart';
import 'info_input.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
              backgroundColor: Colors.black,
            ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const InfoInput(),
    );
  }
}
