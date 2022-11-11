import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';

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

    print(location.latitude);
    print(location.longitude);
    print(location.errorMsg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Get Location'),
          onPressed: () {},
        ),
      ),
    );
  }
}
