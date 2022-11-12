import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;

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

  void getWeatherData() async {
    final url = Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('data: ${data.runtimeType}');

      var description = data['weather'][0]['description'];
      var temp = data['main']['temp'];
      print(description);
      print(temp);

    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      getWeatherData();
    } on Exception catch (e) {
      print(e);
    }
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
