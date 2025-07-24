import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final String apikey = "ce93f5c4cad344629aa143152241102";
  final Dio dio;
  final String cityName;
  final String baseUrl = "https://api.weatherapi.com/v1/forecast.json";
  WeatherService({required this.dio, required this.cityName});

  Future<WeatherModel> getWeather() async {
    try {
      Response response = await dio.get("$baseUrl?key=$apikey&q=$cityName");

      WeatherModel weatherModel = WeatherModel.fromjson(response.data);

      if (response.statusCode == 200) {
        return weatherModel;
      } else if (response.statusCode == 400) {
        final String errorMessage = response.data["error"]["message"] ?? "";
        throw (errorMessage);
      } else {
        throw "Unexpected error";
      }
    } on DioException catch (e) {
      final String errorMessage = e.response?.data["error"]["message"] ?? "";
      print(errorMessage);
      throw (errorMessage);
    } catch (e) {
      throw "Unexpected error";
    }
  }
}
