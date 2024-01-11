import 'package:flutter/material.dart';
import 'package:ios_fitness/settings/lists.dart';
import 'package:ios_fitness/screens/exercise_detail.dart';

class SearchHelper {
  final BuildContext context; // BuildContext tanımlayın

  // FocusNode oluşturun

  SearchHelper(this.context); // Constructor ile BuildContext'i alın

  void navigateToExerciseDetail(String selectedExercise) {
    int exerciseIndex = -1;

    if (Constants.exerciseNamesmP.contains(selectedExercise)) {
      exerciseIndex = Constants.exerciseNamesmP.indexOf(selectedExercise);
    } else if (Constants.exerciseNames.contains(selectedExercise)) {
      exerciseIndex = Constants.exerciseNames.indexOf(selectedExercise);
    }

    if (exerciseIndex != -1) {
      String muscle;
      String exerciseName;
      String muscleImage;

      if (exerciseIndex < Constants.exerciseNamesmP.length) {
        muscle = Constants.muscleNamesmP[exerciseIndex];
        exerciseName = Constants.exerciseNamesmP[exerciseIndex];
        muscleImage = Constants.muscleImageP[exerciseIndex];
      } else {
        exerciseIndex -= Constants.exerciseNamesmP.length;
        muscle = Constants.muscleNames[exerciseIndex];
        exerciseName = Constants.exerciseNames[exerciseIndex];
        muscleImage = Constants.muscleImage2[exerciseIndex];
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ExerciseDetailPage(
            muscle: muscle,
            exerciseName: exerciseName,
            muscleImage: muscleImage,
          );
        }),
      );
    }
  }

  void filterExerciseList(String searchText) {
    List<String> filteredList1 = [];
    List<String> filteredList2 = [];

    if (searchText.isEmpty) {
      filteredList1.addAll(Constants.exerciseNamesmP);
      filteredList2.addAll(Constants.exerciseNames);
    } else {
      for (String exercise in Constants.exerciseNamesmP) {
        if (exercise.toLowerCase().contains(searchText.toLowerCase())) {
          filteredList1.add(exercise);
        }
      }
      for (String exercise in Constants.exerciseNames) {
        if (exercise.toLowerCase().contains(searchText.toLowerCase())) {
          filteredList2.add(exercise);
        }
      }
    }

    List<String> filteredExercise = [...filteredList1, ...filteredList2];

    if (filteredExercise.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Search Results'),
            content: SizedBox(
              height: 200,
              width: 200,
              child: ListView.builder(
                itemCount: filteredExercise.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredExercise[index]),
                    onTap: () {
                      Navigator.pop(context);
                      navigateToExerciseDetail(filteredExercise[index]);
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Results Found'),
            content: const Text('There are no exercises matching your search.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
