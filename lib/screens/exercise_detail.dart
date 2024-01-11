import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ios_fitness/bmi/constants.dart';
import 'package:ios_fitness/bmi/reusable_card.dart';
import 'package:ios_fitness/screens/user.dart';
import 'package:ios_fitness/settings/sharedprefenceshelper.dart';

class ExerciseDetailPage extends StatefulWidget {
  final String muscle;
  final String exerciseName;
  final String muscleImage;

  const ExerciseDetailPage({
    Key? key,
    required this.muscle,
    required this.exerciseName,
    required this.muscleImage,
  }) : super(key: key);

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  List<dynamic> exercises = [];
  Map<String, dynamic>? selectedExercise;
  bool isExerciseSaved = false;
  List<String> savedExercises = [];

  final SharedPreferencesHelper sharedPreferencesHelper =
      SharedPreferencesHelper();

// Kullanıcı egzersizi kaydetme

  @override
  void initState() {
    super.initState();
    fetchExercises();
    checkExerciseSaved();
  }

  Future<void> checkExerciseSaved() async {
    savedExercises =
        await sharedPreferencesHelper.getSavedExercises(UserState.usernamestat);
    setState(() {
      isExerciseSaved = savedExercises.contains(
          widget.exerciseName); // Egzersiz kaydedilmişse durumu güncelliyoruz
    });
  }

  Future<void> fetchExercises() async {
    final response = await http.get(
      Uri.parse(
          'https://api.api-ninjas.com/v1/exercises?muscle=${widget.muscle}'),
      headers: {
        'X-Api-Key': 'klKxGPkvZjJKoBPf1O+PCg==k9lAQMCml4O7p0PR',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        exercises = json.decode(response.body);
        selectedExercise = exercises.firstWhere(
          (exercise) => exercise['name'] == widget.exerciseName,
          orElse: () => null,
        );
      });
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Exercise Detail'),
      ),
      body: exercises.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          selectedExercise?['name'] ?? '',
                          style: kExerciseDetail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              print('kaydedildi');
                              sharedPreferencesHelper.saveExercise(
                                  selectedExercise?['name'] ?? '',
                                  UserState.usernamestat);
                            });
                            checkExerciseSaved();
                            sharedPreferencesHelper
                                .printSavedExercises(UserState.usernamestat);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.bookmark,
                                color: isExerciseSaved
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              Text(
                                isExerciseSaved ? 'Saved' : 'Save',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15.0), // İstediğiniz yuvarlaklık derecesi
                        child: Image(
                          image: AssetImage(widget.muscleImage),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ReusableCardPage2(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Muscle: ${selectedExercise?['muscle'].toString().capitalizeFirstLetter()}',
                            style: kResultTextStyle,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Difficulty: ${selectedExercise?['difficulty'].toString().capitalizeFirstLetter()}'
                                .capitalizeFirstLetter(),
                            style: kResultTextStyle,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Instructions:',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue, // Örnek renk
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${selectedExercise?['instructions'].toString().capitalizeFirstLetter()}',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

extension CapitalizeFirstLetterExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

// Text(exercises[0]['name']),
// Text(exercises[0]['muscle']),
// Text(exercises[0]['instructions']),
