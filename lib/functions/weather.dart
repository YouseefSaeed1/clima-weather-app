import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/functions/location.dart';

class Weather {
  Weather();
  final object = CurrentLocation();
  Future<dynamic> getWeather() async {
    await object.getLocation();
    final lat = object.lat;
    final long = object.long;
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=1d1f018b23283ff770055bff5f6d3c12&units=metric');
    final response = await http.get(url);
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  Future<dynamic> getWeatherByName(String name) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=1d1f018b23283ff770055bff5f6d3c12&units=metric');
    final response = await http.get(url);
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (response.body.isEmpty) {
      return null;
    }
    return data;
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
