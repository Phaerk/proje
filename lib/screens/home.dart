import 'package:flutter/material.dart';
import 'package:ios_fitness/screens/exercise_detail.dart';
import 'package:ios_fitness/screens/mostpopularview.dart';
import 'package:ios_fitness/screens/newrealesesview.dart';
import 'package:ios_fitness/screens/user.dart';
import 'package:ios_fitness/settings/onitemtapped.dart';
import 'package:ios_fitness/settings/searchfilter.dart';
import 'package:ios_fitness/settings/lists.dart';
import 'package:ios_fitness/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.username,
  }) : super(key: key);
  final String username;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()),
                              );
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.orange,
                                size: 40,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Welcome ${UserState.usernamestat.capitalizeFirstLetter()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'New Releases',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NewRealesesView()),
                                );
                              },
                              child: const Text(
                                'View all',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          scrollDirection: Axis.horizontal,
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
                                      exerciseName:
                                          Constants.exerciseNames[index],
                                      muscleImage:
                                          Constants.muscleImage2[index],
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Most Popular',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MostPopularView()),
                                );
                              },
                              child: const Text(
                                'View all',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            Constants.mostPopular.length,
                            (index) => WorkoutCard(
                              image: Constants.mostPopular[index],
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ExerciseDetailPage(
                                      muscle: Constants.muscleNamesmP[index],
                                      exerciseName:
                                          Constants.exerciseNamesmP[index],
                                      muscleImage:
                                          Constants.muscleImageP[index],
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
            ],
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
        height: 20,
        margin: const EdgeInsets.only(right: 10),
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
