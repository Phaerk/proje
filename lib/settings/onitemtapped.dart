import 'package:flutter/material.dart';
import 'package:ios_fitness/screens/home.dart'; // Eğer 'Home' ve 'BMICalculator' widget'larını farklı dosyalarda tanımladıysanız ilgili dosyaların yollarını buraya ekleyin

import 'package:ios_fitness/screens/profile.dart';
import 'package:ios_fitness/screens/user.dart';
import 'map.dart';
import 'package:ios_fitness/screens/saved.dart';

class NavigationHelper {
  static void onItemTapped(BuildContext context, int selectedIndex) {
    if (selectedIndex == 0) {
      // 'Home' seçildiğinde yapılacak işlemler
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Home(
            username: UserState.usernamestat,
          );
        }),
      );
    } else if (selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Saved();
          },
        ),
      );
    } else if (selectedIndex == 2) {
      MapHelper.openGoogleMaps();
    } else if (selectedIndex == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ProfileScreen();
          },
        ),
      );
    }
    // Diğer sekmeler için benzer şekilde işlevler ekleyebilirsiniz.
  }
}
