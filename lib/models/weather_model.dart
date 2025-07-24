import 'package:flutter/material.dart';

class WeatherModel {
  final String cityname;
  final DateTime date;
  final double maxTempC;
  final double minTempC;
  final String image;
  final String weatherkind;
  final double temp;

  const WeatherModel({
    required this.cityname,
    required this.date,
    required this.image,
    required this.maxTempC,
    required this.minTempC,
    required this.temp,
    required this.weatherkind,
  });
  MaterialColor getThemeColor() {
    if (weatherkind == 'Sunny' ||
        weatherkind == 'Clear' ||
        weatherkind == 'partly cloudy') {
      return Colors.orange;
    } else if (weatherkind == 'Blizzard' ||
        weatherkind == 'Patchy snow possible' ||
        weatherkind == 'Patchy sleet possible' ||
        weatherkind == 'Patchy freezing drizzle possible' ||
        weatherkind == 'Blowing snow') {
      return Colors.blue;
    } else if (weatherkind == 'Freezing fog' ||
        weatherkind == 'Fog' ||
        weatherkind == 'Heavy Cloud' ||
        weatherkind == 'Mist' ||
        weatherkind == 'Fog') {
      return Colors.blueGrey;
    } else if (weatherkind == 'Patchy rain nearby' ||
        weatherkind == 'Heavy Rain' ||
        weatherkind == 'Showers	') {
      return Colors.blue;
    } else if (weatherkind == 'Thundery outbreaks possible' ||
        weatherkind == 'Moderate or heavy snow with thunder' ||
        weatherkind == 'Patchy light snow with thunder' ||
        weatherkind == 'Moderate or heavy rain with thunder' ||
        weatherkind == 'Patchy light rain with thunder') {
      return Colors.deepPurple;
    } else {
      return Colors.orange;
    }
  }

  factory WeatherModel.fromjson(Map<String, dynamic> json) {
    return WeatherModel(
      cityname: json["location"]["name"],
      date: DateTime.parse(json["location"]["localtime"]),
      image: json["forecast"]["forecastday"][0]["day"]["condition"]["icon"],
      maxTempC: json["forecast"]["forecastday"][0]["day"]["maxtemp_c"],
      minTempC: json["forecast"]["forecastday"][0]["day"]["mintemp_c"],
      temp: json["current"]["temp_c"],
      weatherkind:
          json["forecast"]["forecastday"][0]["day"]["condition"]["text"],
    );
  }
}
