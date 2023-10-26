import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_servce.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('3a9b97a95e0128870c779bf080e08c19');
  Weather? _weather;

  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState((){
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    switch(mainCondition?.toLowerCase()){
      case 'clouds':
        return 'assets/cloud.json';
      case 'fog':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/moon.json';
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(  
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? "Loading City Name...", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),

          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          Text('${_weather?.temperatures.round()}°C', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),

          Text(_weather?.mainCondition ?? "", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
      ],)
    ));
  }
}