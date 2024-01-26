import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/home_controller.dart';
import '../model/weather_forecast.dart';

class FutureWeather extends StatefulWidget {
  WeatherEntry entry;
  FutureWeather({super.key, required this.entry});

  @override
  State<FutureWeather> createState() => _FutureWeatherState();
}

class _FutureWeatherState extends State<FutureWeather> {
  int getHour() {
    DateTime dateTime = DateTime.parse(widget.entry.dtTxt);
    return dateTime.hour;
  }

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    String selectDayNight(String icontype) {
      String baselottieRoute = 'assets/lotties/';
      String lottiePath = '';

      if (icontype == "01n") {
        lottiePath = "clearmoon.json";
      } else if (icontype == "02n" || icontype == "03n" || icontype == "04n") {
        lottiePath = "cloudymoon.json";
      } else if (icontype == "09n" || icontype == "10n" || icontype == "11n") {
        lottiePath = "rain.json";
      } else if (icontype == "01d") {
        lottiePath = "sunny.json";
      } else if (icontype == "02d" || icontype == "03d" || icontype == "04d") {
        lottiePath = "cloudy.json";
      } else if (icontype == "09d" || icontype == "10d" || icontype == "11d") {
        lottiePath = "rain.json";
      } else {
        lottiePath = "snow.json";
      }

      var finalLottiePath = '$baselottieRoute$lottiePath';
      return finalLottiePath;
    }

    print(widget.entry.weather[0].icon.toString());
    var path = selectDayNight(widget.entry.weather[0].icon.toString());

    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Text(
                '${getHour()} h',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontFamily: 'flutterfonts',
                    ),
              ),
              Lottie.asset(path.toString(), height: 70),
              Text(
                '${(widget.entry.main.temp - 273.15).roundToDouble()} \u2103',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontFamily: 'flutterfonts',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
