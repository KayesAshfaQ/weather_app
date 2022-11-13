import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    //Get the current location
    determineLocation();
  }

  void determineLocation() async {
    final location = Location();
    await location.getUserLocation();

    if (location.errorMsg == null) {
      // print(location.latitude);
      // print(location.longitude);

      final network = NetworkHelper();
      await network.getWeatherData(location.latitude!, location.longitude!);

      if (network.statusCode == 200 && network.errorMsg == null) {
        final data = network.weatherData;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LocationScreen(
              locationWeather: data,
            ),
          ),
        );
      } else {
        print('networkStatusCode: ${network.statusCode}');
        print('networkErrorMessage: ${network.errorMsg}');
      }
    } else {
      print('locationErrorMessage: ${location.errorMsg}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
