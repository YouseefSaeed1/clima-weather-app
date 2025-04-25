import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/functions/weather.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final object = Weather();
    String name = '';
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://scied.ucar.edu/sites/default/files/media/images/weather_0.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  var data = await object.getWeatherByName(name);
                  Navigator.pop(context, data);
                },
                child: const Text(
                  'Get Weather',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
