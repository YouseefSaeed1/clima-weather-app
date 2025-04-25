import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../functions/weather.dart';
import 'weather_by_name_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.locationWeather});
  final dynamic locationWeather;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final object = Weather();
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;
  void updateUi(dynamic data) {
    double temp = data['main']['temp'];
    setState(() {
      temperature = temp.toInt();
      weatherIcon = object.getWeatherIcon(data['weather'][0]['id']);
      cityName = data['name'];
      weatherMessage = object.getMessage(temperature!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.pexels.com/photos/1118873/pexels-photo-1118873.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            fit: BoxFit.fill,
            height: double.infinity,
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () async {
                    var data = await object.getWeather();
                    updateUi(data);
                  },
                  icon: const Icon(
                    CupertinoIcons.location_fill,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      final data = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const NameScreen();
                          },
                        ),
                      );
                      if (data == null) {
                        return;
                      } else {
                        updateUi(data);
                      }
                    },
                    icon: const Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$temperature ° $weatherIcon︎',
                            style: const TextStyle(
                                fontSize: 90, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        '$weatherMessage in $cityName !',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 70, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
