import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/views/search_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: BlocProvider.of<GetWeatherCubit>(
                context,
              ).weatherModel?.getThemeColor(),
              useMaterial3: false,
            ),
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            routes: {
              "/": (context) => HomeView(),
              "/searchview": (context) => SearchView(),
            },
          );
        },
      ),
    );
  }
}
