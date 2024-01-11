import 'package:flutter/material.dart';
import 'package:ios_fitness/settings/onitemtapped.dart';

import 'package:ios_fitness/screens/saved.dart';
import 'package:ios_fitness/screens/user.dart';
import 'package:ios_fitness/settings/sharedprefenceshelper.dart';
import 'package:ios_fitness/screens/exercise_detail.dart';

import '../personalinfo/info_input.dart';

import 'package:ios_fitness/screens/deneme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  // Kullanıcı verileri için varsayılan değerler
  int selectedIndex = 3;
  int dailyWaterIntakeGoal = 2500; // Günlük su hedefi ml cinsinden
  // Egzersiz verileri
  List<String> exercises = ["Yoga", "Koşu", "Kardiyo"];

  int savedHeight = 180;
  int savedWeight = 70;
  int savedAge = 30;
  String savedGender = 'male';
  Color personalColor = const Color(0xFF1C1C1E);
  Color savedColor = const Color(0xFF1C1C1E);
  Color containerColor = const Color(0xFF1C1C1E);
  Color tapColor = const Color(0xFF3A3A3C);

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    Map<String, dynamic> userData =
        await UserPreferences.getUserPreferences(UserState.usernamestat);
    setState(() {
      savedHeight = userData['height'];
      savedWeight = userData['weight'];
      savedAge = userData['age'];
      savedGender = userData['gender'];
    });
  }

  // Günlük kalori ihtiyacını hesaplayan basit bir fonksiyon
  int calculateDailyCalorieNeed() {
    // Burada basit bir formül kullanılabilir
    // Örnek olarak, Mifflin-St Jeor formülü: (10 * weight) + (6.25 * height) - (5 * age) + 5
    return ((10 * savedWeight) + (6.25 * savedHeight) - (5 * savedAge) + 5)
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius:
                    BorderRadius.circular(10), // Kenarları yuvarlamak için
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.orange,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    ' ${UserState.usernamestat.capitalizeFirstLetter()}',
                    style: const TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  personalColor = tapColor;
                });
              },
              onTapUp: (details) {
                setState(() {
                  personalColor =
                      containerColor; // Dokunmayı bırakınca eski rengine döner
                });
              },
              onTapCancel: () {
                setState(() {
                  personalColor =
                      containerColor; // Dokunma iptal edilince eski rengine döner
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InfoInput(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: personalColor,
                  borderRadius:
                      BorderRadius.circular(10), // Kenarları yuvarlamak için
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                            5), // Kenarları yuvarlamak için
                      ),
                      width: 40, // Genişlik
                      height: 40,
                      child: const Icon(
                        Icons.badge,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Your Personal Infos',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  savedColor = tapColor;
                });
              },
              onTapUp: (details) {
                setState(() {
                  savedColor =
                      containerColor; // Dokunmayı bırakınca eski rengine döner
                });
              },
              onTapCancel: () {
                setState(() {
                  savedColor =
                      containerColor; // Dokunma iptal edilince eski rengine döner
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Saved()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: savedColor,
                  borderRadius:
                      BorderRadius.circular(10), // Kenarları yuvarlamak için
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(
                            5), // Kenarları yuvarlamak için
                      ),
                      width: 40, // Genişlik
                      height: 40, // Yükseklik

                      child: const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Saved Exercises',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  savedColor = tapColor;
                });
              },
              onTapUp: (details) {
                setState(() {
                  savedColor =
                      containerColor; // Dokunmayı bırakınca eski rengine döner
                });
              },
              onTapCancel: () {
                setState(() {
                  savedColor =
                      containerColor; // Dokunma iptal edilince eski rengine döner
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DailyWater()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: savedColor,
                  borderRadius:
                      BorderRadius.circular(10), // Kenarları yuvarlamak için
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                            5), // Kenarları yuvarlamak için
                      ),
                      width: 40, // Genişlik
                      height: 40, // Yükseklik

                      child: const Icon(
                        Icons.water_drop,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Daily Water Goal',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
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
