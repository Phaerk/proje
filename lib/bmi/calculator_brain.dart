import 'dart:math';

class CalculatorBrain {
  const CalculatorBrain({
    required this.height,
    required this.weight,
    // required this.age,
    // required this.gender,
  });

  final int height;
  final int weight;
  // final int age;
  // final String gender;

  String calculateBMI() {
    double bmi = weight / pow(height / 100, 2);

    return bmi.toStringAsFixed(1);
  }

  String getResult() {
    double bmi = double.parse(calculateBMI());

    if (bmi >= 25) {
      return 'Overweight';
    } else if (bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    double bmi = double.parse(calculateBMI());
    if (bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (bmi >= 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}
