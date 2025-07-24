import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

// ignore: must_be_immutable
class SearchView extends StatelessWidget {
  const SearchView({super.key});

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
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
        title: Text(
          "search city",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              onSubmitted: (value) {
                BlocProvider.of<GetWeatherCubit>(
                  context,
                ).getWeatherFunc(cityName: value);
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                labelText: "search",
                hintText: "enter city name",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
