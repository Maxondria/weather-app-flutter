import 'dart:convert';

import 'package:clima/models/weather_model.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/current_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherModel {
  String apiKey = '9860ad09fd0c5c0eacb90ea9114c5cdc';
  String baseURL = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getLocationData() async {
    Weather weather;
    try {
      Position position = await Location().getCurrentLocation();

      String url =
          '$baseURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';

      NetworkHelper networkHelper = NetworkHelper(url: url);

      http.Response response = await networkHelper.fetchData();
      weather = Weather.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e.cause);
      weather = Weather(
          temp: 0.0,
          icon: 'Error',
          description: 'Error',
          city: '',
          id: 0.0,
          main: 0.0,
          humidity: 'Error');
    }
    return weather;
  }

  Future<Weather> getCityWeather(String cityname) async {
    String url = '$baseURL?q=$cityname&appid=$apiKey&units=metric';

    Weather weather;

    NetworkHelper networkHelper = NetworkHelper(url: url);

    try {
      http.Response response = await networkHelper.fetchData();
      weather = Weather.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e.cause);
      weather = Weather(
          temp: 0.0,
          icon: 'Error',
          description: 'Error',
          city: '',
          id: 0.0,
          main: 0.0,
          humidity: 'Error');
    }
    return weather;
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
    if (temp <= 0) {
      return 'Unable to get weather data';
    } else if (temp > 25) {
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
