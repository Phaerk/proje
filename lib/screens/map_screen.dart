import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Position? currentPosition;
  late final Uri url;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // İzin reddedildiğinde bir uyarı gösterebilirsiniz.
        }
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          currentPosition = position;
          url = Uri.parse(
              'https://www.google.com/maps/search/fitness+centers/@${currentPosition!.latitude},${currentPosition!.longitude}');
        });
      }
    } else {
      // Konum servisi kapalıysa, kullanıcıyı ayarlara yönlendirin.
    }
  }

  void openGoogleMaps() async {
    if (currentPosition != null) {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            openGoogleMaps();
          },
          child: const Text('Find Nearby Gyms'),
        ),
      ),
    );
  }
}
