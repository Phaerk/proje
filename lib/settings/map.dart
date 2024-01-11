import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class MapHelper {
  static Future<Position?> _getCurrentPosition() async {
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
        return await Geolocator.getCurrentPosition();
      }
    } else {
      // Konum servisi kapalıysa, kullanıcıyı ayarlara yönlendirin.
    }
    return null;
  }

  static Future<void> openGoogleMaps() async {
    Position? currentPosition = await _getCurrentPosition();
    if (currentPosition != null) {
      final Uri url = Uri.parse(
          'https://www.google.com/maps/search/fitness+centers/@${currentPosition.latitude},${currentPosition.longitude}');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
