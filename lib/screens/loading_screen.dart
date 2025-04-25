import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_screen.dart';
import '../functions/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final object = Weather();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await object.getWeather();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return WeatherScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
