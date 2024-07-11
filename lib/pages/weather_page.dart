import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatheraService = WeatherService('233f6935713cedf3f3a9b7d7c9341520');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatheraService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatheraService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }

  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/cloudy.json';
      case 'fog':
        return 'assets/foggy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'snow':
        return 'assets/snowy.json';
      case 'clear':
        return 'assets/sunny.json';
    }

    return 'assets/sunny.json';
  }

  //init state
  @override
  void initState() {
    super.initState();

    // fetch weather on start up
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loafing city.."),

            //weather animations
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        
            //temperature
            Text('${_weather?.temperature.round()}°C'),

            //condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}