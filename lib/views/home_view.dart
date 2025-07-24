import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/widget/no_weather_body.dart';
import 'package:weather_app/widget/weather_body_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/searchview");
              },
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
        title: Text(
          "weather app",
          style: TextStyle(
            color: const Color.fromARGB(255, 72, 71, 71),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialstate) {
            return NoWeatherBody();
          } else if (state is WeatherLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoadedState) {
            return WeatherBodyView(weatherModel: state.weatherModel);
          } else {
            return Text("error");
          }
        },
      ),
    );
  }
}
