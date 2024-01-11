import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_fitness/bmi/card_column.dart';
import 'package:ios_fitness/bmi/reusable_card.dart';
import 'package:ios_fitness/bmi/constants.dart';
import 'package:ios_fitness/bmi/results_page.dart';

import 'package:ios_fitness/bmi/round_icon_button.dart';
import 'package:ios_fitness/bmi/calculator_brain.dart';
import 'package:ios_fitness/settings/onitemtapped.dart';
import 'package:ios_fitness/settings/sharedprefenceshelper.dart';

import '../screens/user.dart';

enum Gender {
  male,
  female,
}

class InfoInput extends StatefulWidget {
  const InfoInput({super.key});

  @override
  State<InfoInput> createState() => _InfoInputState();
}

class _InfoInputState extends State<InfoInput> {
  int selectedIndex = 1;
  Color maleCardColor = kInactiveCardColor;
  Color femaleCardColor = kInactiveCardColor;

  Color maleIconColor = Colors.white;
  Color femaleIconColor = Colors.white;

  void maleUp() {
    if (maleIconColor == kInactiveIconColor) {
      maleIconColor = kMaleActiveIconColor;
      femaleIconColor = kInactiveIconColor;
    }
  }

  void femaleUp() {
    if (femaleIconColor == kInactiveIconColor) {
      femaleIconColor = kfeMaleActiveIconColor;
      maleIconColor = kInactiveIconColor;
    }
  }

  int savedHeight = 180;
  int savedWeight = 70;
  int savedAge = 22;
  String savedGender = 'male';
  String saveString = 'SAVE';

  void defGender() {
    if (savedGender == 'female') {
      femaleUp();
    } else {
      maleUp();
    }
  }

  void getUserData() async {
    Map<String, dynamic> userData =
        await UserPreferences.getUserPreferences(UserState.usernamestat);
    setState(() {
      savedHeight = (userData['height'] != 0) ? userData['height'] : 180;

      savedWeight = (userData['weight'] != 0) ? userData['weight'] : 70;

      savedAge = (userData['age'] != 0) ? userData['age'] : 30;

      savedGender = userData['gender'];
      defGender();
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Personal Infos',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ReusableCard(
                      pressHandler: () {
                        setState(() {
                          maleUp();
                          saveString = 'SAVE';
                        });
                      },
                      color: maleCardColor,
                      cardChild: CardColumn(
                        textstring: 'MALE',
                        icon: FontAwesomeIcons.mars,
                        iconcolor: maleIconColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ReusableCard(
                      pressHandler: () {
                        setState(() {
                          femaleUp();
                          saveString = 'SAVE';
                        });
                      },
                      color: femaleCardColor,
                      cardChild: CardColumn(
                        textstring: 'FEMALE',
                        icon: FontAwesomeIcons.venus,
                        iconcolor: femaleIconColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ReusableCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'HEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                savedHeight.toString(),
                                style: kNumberTextStyle,
                              ),
                              const Text(
                                'cm',
                                style: kLabelTextStyle,
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              inactiveTrackColor: const Color(0xFF8D8E98),
                              activeTrackColor: Colors.white,
                              thumbColor: const Color(0xFFEB1555),
                              overlayColor: const Color(0x29EB1555),
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 15.0,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 30.0,
                              ),
                            ),
                            child: Slider(
                                value: savedHeight.toDouble(),
                                min: 120.0,
                                max: 220.0,
                                onChanged: (double newValue) {
                                  setState(() {
                                    savedHeight = newValue.round();
                                    saveString = 'SAVE';
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ReusableCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            savedWeight.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    savedWeight = savedWeight - 1;
                                    saveString = 'SAVE';
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    savedWeight = savedWeight + 1;
                                    saveString = 'SAVE';
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ReusableCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'AGE',
                            style: kLabelTextStyle,
                          ),
                          Text(
                            savedAge.toString(),
                            style: kNumberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    savedAge = savedAge - 1;
                                    saveString = 'SAVE';
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    savedAge = savedAge + 1;
                                    saveString = 'SAVE';
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(
                          10), // Kenarları yuvarlamak için
                    ),
                    child: const Text(
                      'CALCULATE BMI',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    await UserPreferences.saveUserPreferences(
                      height: savedHeight,
                      weight: savedWeight,
                      age: savedAge,
                      gender: (maleIconColor == kMaleActiveIconColor)
                          ? 'male'
                          : 'female',
                      username: UserState.usernamestat,
                    );
                    CalculatorBrain calc = CalculatorBrain(
                        height: savedHeight, weight: savedWeight);
                    String bmiresult = calc.calculateBMI();
                    String resulttext = calc.getResult();
                    String finaltext = calc.getInterpretation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ResultsPage(
                          bmiResult: bmiresult,
                          resultText: resulttext,
                          interpretation: finaltext,
                        );
                      }),
                    );
                  },
                ),
                TextButton(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(
                          10), // Kenarları yuvarlamak için
                    ),
                    child: Text(
                      saveString,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      saveString = 'SAVED';
                    });

                    await UserPreferences.saveUserPreferences(
                      height: savedHeight,
                      weight: savedWeight,
                      age: savedAge,
                      gender: (maleIconColor == kMaleActiveIconColor)
                          ? 'male'
                          : 'female',
                      username: UserState.usernamestat,
                    );
                  },
                ),
              ],
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
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: 'Calculate BMI'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Studio'),
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
