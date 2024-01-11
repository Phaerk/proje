class Constants {
  static List<String> newReleases = [
    'images/images1.jpeg',
    'images/incline_hammer.jpg',
    'images/images3.jpeg',
    'images/standingcalfraises0.jpeg',
    'images/wrist.jpeg',
  ];

  static List<String> muscleNames = [
    'biceps',
    'biceps',
    'lats',
    'calves',
    'forearms',
    // 'abductors-6',
    // 'biceps-0',
    // 'lats-1',
  ];

  static List<String> exerciseNames = [
    'Barbell Curl',
    'Incline Hammer Curls',
    'Pullups',
    'Standing Calf Raises',
    'Seated finger curl',
    // 'abductors-6',
    // 'biceps-0',
    // 'lats-1',
  ];

  static List<String> muscleImage2 = [
    'assets/1barbell_curll.gif',
    'assets/2incline_hammer_curl.gif',
    'assets/3pullups.gif',
    'assets/standing-calf-raise.gif',
    'assets/5fingercurl.gif',
  ];

  static List<String> mostPopular = [
    'images/images4.jpeg',
    'images/images5.jpeg',
    'images/images1.jpeg',
  ];

  static List<String> muscleNamesmP = [
    'chest',
    'chest',
    'biceps',
    // 'abductors-6',
    // 'biceps-0',
    // 'lats-1',
  ];

  static List<String> exerciseNamesmP = [
    'Dumbbell Bench Press',
    'Pushups',
    'Barbell Curl',
    // 'abductors-6',
    // 'biceps-0',
    // 'lats-1',
  ];

  static List<String> muscleImageP = [
    'assets/benchpress.gif',
    'assets/pushups.gif',
    'assets/1barbell_curll.gif',
  ];

  static Map<String, Map<String, String>> exercises = {
    'Barbell Curl': {
      'exerciseImage': 'images/images1.jpeg',
      'muscleName': 'biceps',
      'muscleImage': 'assets/1barbell_curll.gif',
    },
    'Incline Hammer Curls': {
      'exerciseImage': 'images/incline_hammer.jpg',
      'muscleName': 'biceps',
      'muscleImage': 'assets/inclinehammer2.png',
    },
    'Pullups': {
      'exerciseImage': 'images/images3.jpeg',
      'muscleName': 'lats',
      'muscleImage': 'assets/pullup2.png',
    },
    'Dumbbell Bench Press': {
      'exerciseImage': 'images/images4.jpeg',
      'muscleName': 'chest',
      'muscleImage': 'benchpress.gif',
    },
    'Pushups': {
      'exerciseImage': 'images/images5.jpeg',
      'muscleName': 'chest',
      'muscleImage': 'pushups.gif',
    },
    'Standing Calf Raises': {
      'exerciseImage': 'images/standingcalfraises0.jpeg',
      'muscleName': 'calves',
      'muscleImage': 'assets/standing-calf-raise.gif',
    },
    'Seated finger curl': {
      'exerciseImage': 'images/wrist.jpeg',
      'muscleName': 'forearms',
      'muscleImage': 'assets/5fingercurl.gif',
    },
  };
}
