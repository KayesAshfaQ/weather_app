import 'dart:convert';

import 'package:weather_app/utilities/constant_strings.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  late final int statusCode;
  late final weatherData;
  String? errorMsg;

  Future<void> getWeatherData(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherApiKey&units=metric');
    http.Response response = await http.get(url);

    statusCode = response.statusCode;
    //print('networking: $statusCode');
    if (statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseCode = data['cod'];

      if (responseCode == 200) {
        //print('responsecode $responseCode');
        weatherData = data;
      } else {
        errorMsg = data['message'];
      }
    }
  }
}
