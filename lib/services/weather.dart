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

  Future<dynamic> getCityWeather(String cityName) async {
    final network = NetworkHelper();
    await network.getCityWeatherData(cityName);

    if (network.statusCode == 200 &&
        network.errorMsg == null &&
        network.weatherData != null) {
      return network.weatherData;
    } else {
      return Future.error(
          'networkStatusCode: ${network.statusCode}\nnetworkErrorMessage: ${network.errorMsg}');
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
