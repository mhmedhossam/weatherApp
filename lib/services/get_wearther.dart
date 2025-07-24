import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart'; // Ensure this path is correct

/// A service class for fetching weather data.
class WeatherService {
  // It's generally better to keep sensitive information like API keys
  // out of the source code directly, especially for production apps.
  // Consider using environment variables or a secure configuration file.
  // For this example, we'll keep it here for simplicity, but be aware.
  final String _apiKey = "ce93f5c4cad344629aa143152241102"; // Made private
  final Dio _dio; // Made private
  final String _baseUrl =
      "https://api.weatherapi.com/v1/forecast.json"; // Made private

  WeatherService({required Dio dio})
    : _dio = dio; // Initialize dio via constructor

  /// Fetches weather data for a given city.
  ///
  /// Throws a [WeatherServiceException] if an error occurs during the API call
  /// or data processing.
  Future<WeatherModel> getWeather({required String cityName}) async {
    try {
      final Response response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'key': _apiKey,
          'q': cityName,
          'days': 1, // Added to explicitly request forecast for 1 day
        },
      );

      // It's good practice to check the status code before attempting to parse.
      // Dio generally throws a DioException for non-2xx status codes by default
      // if validateStatus is not overridden.
      if (response.statusCode == 200) {
        // Use a null-aware operator or explicit type checking for safety
        if (response.data == null) {
          throw WeatherServiceException('No data received from weather API.');
        }
        return WeatherModel.fromjson(response.data);
      } else {
        // This block might be less frequently hit if Dio handles non-2xx statuses,
        // but it's good to have a fallback.
        final String errorMessage =
            response.data?["error"]?["message"] ?? "An unknown error occurred.";
        throw WeatherServiceException(errorMessage);
      }
    } on DioException catch (e) {
      // Handle different types of DioExceptions more granularly
      String errorMessage = 'Failed to fetch weather data.';

      if (e.response != null) {
        // Extract error message from API response if available
        errorMessage = e.response!.data?["error"]?["message"] ?? errorMessage;
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection. Please check your network.';
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Connection timed out. Please try again later.';
      }
      // Log the error for debugging purposes (consider using a proper logging package)
      print('DioException in WeatherService: $errorMessage - ${e.message}');
      throw WeatherServiceException(
        errorMessage,
        e,
      ); // Pass original exception for more context
    } catch (e) {
      // Catch any other unexpected errors
      print('Unexpected error in WeatherService: $e');
      throw WeatherServiceException(
        'An unexpected error occurred: ${e.toString()}',
        e,
      );
    }
  }
}

/// Custom exception for weather service related errors.
class WeatherServiceException implements Exception {
  final String message;
  final dynamic originalException; // To hold the original exception if needed

  WeatherServiceException(this.message, [this.originalException]);

  @override
  String toString() {
    return 'WeatherServiceException: $message';
  }
}
