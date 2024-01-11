import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:ios_fitness/screens/user.dart';
import 'package:ios_fitness/settings/sharedprefenceshelper.dart';

class DailyWater extends StatefulWidget {
  const DailyWater({Key? key}) : super(key: key);

  @override
  State<DailyWater> createState() => DailyWaterState();
}

class DailyWaterState extends State<DailyWater> {
  StateMachineController? controller;
  SMIInput<double>? inputValue;

  double currentLevel = 0;

  int savedHeight = 180;
  int savedWeight = 70;
  int savedAge = 30;
  String savedGender = 'male';

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
  double calculateDailyWaterNeed() {
    // Burada basit bir formül kullanılabilir
    // Örnek olarak, Mifflin-St Jeor formülü: (10 * weight) + (6.25 * height) - (5 * age) + 5
    return ((savedWeight / 128 * 3.785) * 1000).toDouble();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (currentLevel / calculateDailyWaterNeed())
        .clamp(0, 1); // Yüzdesel hesaplama

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black45,
        title: Text('Daily Water Track'),
      ),
      body: Stack(
        children: [
          RiveAnimation.asset(
            "assets/water-bar-demo.riv",
            fit: BoxFit.cover,
            onInit: (artboard) {
              controller = StateMachineController.fromArtboard(
                artboard,
                "State Machine",
              );

              if (controller != null) {
                artboard.addController(controller!);
                inputValue = controller?.findInput("Level");
                inputValue?.change(currentLevel);
              }
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (percentage >= 1.0)
                  const SizedBox(
                    height:
                        20, // Congrats yazısı ekranda olduğunda diğer bileşenleri itmemek için boşluk ekle
                  ),
                if (percentage >= 1.0)
                  const Text(
                    'Congrats, You Reached Your Daily Goal !',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Helvatica',
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Text(
                  '     ${(percentage * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 35,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 70,
                              child: Image.asset(
                                'assets/bottle.png',
                              ),
                            ),
                            const Text(
                              '500ml',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            TextButton(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(
                                      10), // Kenarları yuvarlamak için
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                updateLevel(500);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 70,
                              child: Image.asset(
                                'assets/glass.png',
                              ),
                            ),
                            const Text(
                              '200ml',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            TextButton(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(
                                      10), // Kenarları yuvarlamak için
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                updateLevel(200);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(
                          10), // Kenarları yuvarlamak için
                    ),
                    child: const Text(
                      'RESET',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    updateLevel(-calculateDailyWaterNeed());
                  },
                ),
                Text(
                  '     ${currentLevel.toInt()} ml / ${calculateDailyWaterNeed().toInt()} ml',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: 'Helvetica'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateLevel(double amount) {
    setState(() {
      currentLevel =
          (currentLevel + amount).clamp(0, calculateDailyWaterNeed());
      inputValue?.change(currentLevel / 50);
    });
  }
}

// Align(
// alignment: Alignment.bottomCenter,
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Text(
// 'Yüzde: ${(percentage * 100).toStringAsFixed(1)}%',
// style: TextStyle(fontSize: 18),
// ),
// Text(
// 'Günlük Su İhtiyacı: $dailyGoal ml',
// style: TextStyle(fontSize: 18),
// ),
// SizedBox(height: 20),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// GestureDetector(
// onTap: () {
// updateLevel(-100); // Her tıklamada azalan su miktarı
// },
// child: Container(
// height: 50,
// width: 50,
// color: Colors.red,
// child: Icon(Icons.remove),
// ),
// ),
// SizedBox(width: 20),
// GestureDetector(
// onTap: () {
// updateLevel(100); // Her tıklamada artan su miktarı
// },
// child: Container(
// height: 50,
// width: 50,
// color: Colors.green,
// child: Icon(Icons.add),
// ),
// ),
// ],
// ),
// SizedBox(height: 20),
// Text(
// 'Su Seviyesi: $currentLevel ml / $dailyGoal ml',
// style: TextStyle(fontSize: 18),
// ),
// SizedBox(height: 10),
// ],
// ),
// ),
// ],
// ),
// );
// }
