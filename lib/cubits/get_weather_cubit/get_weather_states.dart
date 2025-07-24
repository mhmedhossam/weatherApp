import 'package:weather_app/models/weather_model.dart';

class WeatherState {}

class WeatherInitialstate extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherModel;
  WeatherLoadedState({required this.weatherModel});
}

class WeatherFailureState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}
