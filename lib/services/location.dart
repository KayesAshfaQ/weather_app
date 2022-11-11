import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  void getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('location access failed!');
    }
  }
}
