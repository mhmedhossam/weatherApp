import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherBodyView extends StatelessWidget {
  final WeatherModel weatherModel;
  const WeatherBodyView({super.key, required this.weatherModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            weatherModel.getThemeColor(),
            weatherModel.getThemeColor()[300]!,
            weatherModel.getThemeColor()[200]!,
            weatherModel.getThemeColor()[50]!,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weatherModel.cityname,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Text(
            "updated at : ${weatherModel.date.hour} :${weatherModel.date.minute} ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: weatherModel.image.contains("https:")
                    ? Image.network(weatherModel.image)
                    : Image.network("https:${weatherModel.image}"),
              ),
              Text(
                weatherModel.temp.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),

              Column(
                children: [
                  Text("maxtemp:${weatherModel.maxTempC.round()}"),
                  Text("mintemp:${weatherModel.maxTempC.round()}"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            weatherModel.weatherkind,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
