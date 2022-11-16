import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

class WeatherModel {

  Future<dynamic> getWeather() async {
    final location = Location();
    await location.getUserLocation();

    if (location.errorMsg == null) {
      // print(location.latitude);
      // print(location.longitude);

      final network = NetworkHelper();
      await network.getWeatherData(location.latitude!, location.longitude!);

      if (network.statusCode == 200 &&
          network.errorMsg == null &&
          network.weatherData != null) {
        return network.weatherData;
      } else {
        return Future.error(
            'networkStatusCode: ${network.statusCode}\nnetworkErrorMessage: ${network.errorMsg}');
      }
    } else {
      return Future.error('locationErrorMessage: ${location.errorMsg}');
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
