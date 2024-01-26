import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/home_controller.dart';

import 'package:weather_app/view/loading_screen.dart';
import 'package:weather_app/widgets/future_weather.dart';

import '../model/weather_forecast.dart';
import '../widgets/current_day_card.dart';
import '../widgets/temp_chart.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          if (controller.current == false && controller.forecast == false) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            controller.backgroundImagePath.toString()),
                        fit: BoxFit.cover),
                  ),
                  height: double.infinity,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          MyCard(),
                          SizedBox(
                            height: 130,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                WeatherEntry entry =
                                    controller.forecastData.list![index];
                                return FutureWeather(
                                  entry: entry,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TempChart(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return LoadingScreen();
        }));
  }
}
