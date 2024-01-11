import 'package:flutter/material.dart';

import 'package:ios_fitness/screens/exercise_detail.dart';
import 'package:ios_fitness/screens/user.dart';

import 'package:ios_fitness/settings/onitemtapped.dart';

import 'package:ios_fitness/settings/lists.dart';
import 'package:ios_fitness/settings/searchfilter.dart';
import 'package:ios_fitness/settings/sharedprefenceshelper.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _Saved();
}

class _Saved extends State<Saved> {
  int selectedIndex = 1;
  final searchController = TextEditingController();
  List<String> savedExercises = [];

  @override
  void initState() {
    super.initState();
    loadSavedExercises(); // Kaydedilen egzersizleri yükle
  }

  Future<void> loadSavedExercises() async {
    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
    String username = UserState.usernamestat;

    savedExercises = await sharedPreferencesHelper.getSavedExercises(username);
    setState(() {}); // Widget'ın yeniden çizilmesi için setState kullanın
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TapRegion(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xff121212),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      autofocus: false,
                      controller: searchController,
                      onEditingComplete: () {
                        SearchHelper(context)
                            .filterExerciseList(searchController.text);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What are you looking for?',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 500,
                  width: 400,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                      savedExercises.length,
                      (index) {
                        String exerciseName = savedExercises[index];

                        Map<String, String> exerciseDetails =
                            Constants.exercises[exerciseName] ?? {};
                        return WorkoutCard(
                          image: exerciseDetails['exerciseImage'] ?? '',
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ExerciseDetailPage(
                                  muscle: exerciseDetails['muscleName'] ?? '',
                                  exerciseName: exerciseName,
                                  muscleImage:
                                      exerciseDetails['muscleImage'] ?? '',
                                );
                              }),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Studio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
            NavigationHelper.onItemTapped(context, selectedIndex);
          });
          // Burada 'NavigationHelper' sınıfını kullanarak işlevi çağırabiliriz
        },
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    Key? key,
    required this.image,
    this.ontap,
  }) : super(key: key);
  final String image;

  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 150,
        height: 300,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
