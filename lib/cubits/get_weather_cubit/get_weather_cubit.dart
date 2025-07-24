import 'package:dio/dio.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/get_wearther.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  WeatherModel? weatherModel;
  GetWeatherCubit() : super(WeatherInitialstate());
  getWeatherFunc({required String cityName}) async {
    try {
      emit(WeatherLoadingState());
      weatherModel = await WeatherService(
        dio: Dio(),
      ).getWeather(cityName: cityName);
      emit(WeatherLoadedState(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}
