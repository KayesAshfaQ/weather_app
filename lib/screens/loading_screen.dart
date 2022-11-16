import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';
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

  void determineLocation() {
    WeatherModel().getWeather().then((weatherData) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData);
      }));
    }, onError: (error) {
      print(error);
    });
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
