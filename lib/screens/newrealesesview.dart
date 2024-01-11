import 'package:flutter/material.dart';

import 'package:ios_fitness/screens/exercise_detail.dart';

import 'package:ios_fitness/settings/onitemtapped.dart';

import 'package:ios_fitness/settings/lists.dart';
import 'package:ios_fitness/settings/searchfilter.dart';

class NewRealesesView extends StatefulWidget {
  const NewRealesesView({Key? key}) : super(key: key);

  @override
  State<NewRealesesView> createState() => _NewRealesesState();
}

class _NewRealesesState extends State<NewRealesesView> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

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
                      Constants.newReleases.length,
                      (index) => WorkoutCard(
                        image: Constants.newReleases[index],
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ExerciseDetailPage(
                                muscle: Constants.muscleNames[index],
                                exerciseName: Constants.exerciseNames[index],
                                muscleImage: Constants.muscleImage2[index],
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
          // Burada 'NavigationHelper' sınıfını kullanarak işlevi çağırabiliriz
          NavigationHelper.onItemTapped(context, selectedIndex);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: 'Calculate BMI'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Studio'),
        ],
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
