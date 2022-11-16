import 'dart:convert';

import 'package:weather_app/utilities/constant_strings.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  late final int statusCode;
  late final weatherData;
  String? errorMsg;

  Future<void> getCityWeatherData(String cityName) async {
    final url = Uri.parse(
        '$openWeatherMapUrl?q=$cityName&appid=$weatherApiKey&units=metric');
    var response = await http.get(url);
    processResponseData(response);
  }

  Future<void> getWeatherData(double lat, double lon) async {
    final url = Uri.parse(
        '$openWeatherMapUrl?lat=$lat&lon=$lon&appid=$weatherApiKey&units=metric');
    var response = await http.get(url);
    processResponseData(response);
  }

  void processResponseData(http.Response response) {
    statusCode = response.statusCode;
    //print('networking: $statusCode');
    if (statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseCode = data['cod'];

      if (responseCode == 200) {
        //print('responsecode $responseCode');
        weatherData = data;
        print(weatherData);
      } else {
        errorMsg = data['message'];
      }
    } else {
      errorMsg = 'Something went wrong';
    }
  }
}
